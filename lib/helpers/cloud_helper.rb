module Helpers
  class Client
    def setup; end
  end

  class GCPClient < Client
    def initialize; end

    def setup
      credentials
      filestore
      persistent_volume
      persistent_volume_claim
    end

    def credentials
      rm_rf '/home/go/.config/gcloud/legacy_credentials'
      mkdir_p '/home/go/.config/gcloud/legacy_credentials'
      gcloud_credentials = {
        client_email: ENV['GCP_SA_CLIENT_EMAIL'],
        client_id: ENV['GCP_CLIENT_ID'],
        private_key: ENV['GCP_PRIVATE_KEY'],
        private_key_id: ENV['GCP_PRIVATE_KEY_ID'],
        type: 'service_account'
      }
      File.open('/home/go/.config/gcloud/legacy_credentials/adc.json', 'w') { |file| file.write(gcloud_credentials.to_json) }
    end

    def filestore
      sh %(gcloud filestore instances create reg-test \
      --project=studios-gcp-gocd \
      --location=us-central1-c \
      --tier=STANDARD \
      --file-share=name="NFSvol",capacity=1TB \
      --network=name="default",reserved-ip-range="10.0.7.0/29")
    end

    def filestore_ip
      stdout, _stdeerr, _status = Open3.capture3(%(gcloud filestore instances describe reg-test --project=studios-gcp-gocd --zone=us-central1-c --format='value(networks.ipAddresses)'))
      stdout.delete("\n").split("'")[1]
    end

    def persistent_volume
      pv = %(apiVersion: v1
          kind: PersistentVolume
          metadata:
              name: fileserver
          spec:
              capacity:
                storage: 1T
              accessModes:
              - ReadWriteMany
              nfs:
                path: /NFSvol
                server: #{filestore_ip})

      File.open('pv.yaml', 'w') { |file| file.write(pv) }
      sh %(kubectl create -f pv.yaml)
   end

    def persistent_volume_claim
        pvc = %(apiVersion: v1
          kind: PersistentVolumeClaim
          metadata:
            name: fileserver-claim
          spec:
            accessModes:
            - ReadWriteMany
            storageClassName: ""
            resources:
                requests:
                storage: 1G)
        File.open('pvc.yaml', 'w') { |file| file.write(pvc) }
        sh %(kubectl create -f pvc.yaml)
     end
   end
end
