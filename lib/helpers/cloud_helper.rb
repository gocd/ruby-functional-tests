require 'fileutils'
require 'open3'
require 'yaml'
require 'pry'
module Helpers
  class Client
    include FileUtils

    def run_or_bomb(command)
      stdout, stdeerr, status = Open3.capture3(command)
      raise "Command #{command} failed with error #{stdeerr}" unless status.success?
      stdout
    end
  end

  class GCPClient < Client
    def initialize
      @project = 'studios-gcp-gocd'
      @zone = 'us-central1-a'
    end

    def setup
      credentials
      connect_to_k8s_cluster
      filestore('create')
      persistent_volume('create')
      persistent_volume_claim('create')
    end

    def teardown
      credentials
      connect_to_k8s_cluster
      persistent_volume_claim('delete')
      persistent_volume('delete')
      filestore('delete')
    end

    def credentials
      rm_rf '/go/.config/gcloud'
      mkdir_p '/go/.config/gcloud'
      gcloud_key = {
        type: 'service_account',
        project_id: @project.to_s,
        client_email: ENV['GCP_SA_CLIENT_EMAIL'],
        client_id: ENV['GCP_CLIENT_ID'],
        private_key: eval(%Q("#{ENV['GCP_PRIVATE_KEY']}")),
        private_key_id: ENV['GCP_PRIVATE_KEY_ID'],
        auth_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_uri: 'https://oauth2.googleapis.com/token',
        auth_provider_x509_cert_url: 'https://www.googleapis.com/oauth2/v1/certs',
        client_x509_cert_url: 'https://www.googleapis.com/robot/v1/metadata/x509/performance-tester%40studios-gcp-gocd.iam.gserviceaccount.com'
      }
      File.open('/go/.config/gcloud/key_file.json', 'w') { |file| file.write(gcloud_key.to_json) }
      run_or_bomb %(gcloud auth activate-service-account #{ENV['GCP_SA_CLIENT_EMAIL']} --key-file='/go/.config/gcloud/key_file.json')
    end

    def connect_to_k8s_cluster
      run_or_bomb %(gcloud container clusters get-credentials gocd-regression-test --zone #{@zone} --project #{@project})
    end

    def filestore(action)
      if action == 'delete'
        run_or_bomb %(gcloud filestore instances #{action} --quiet reg-test \
                      --project=#{@project} \
                      --zone=#{@zone})
      else
        run_or_bomb %(gcloud filestore instances #{action} reg-test \
                      --project=#{@project} \
                      --zone=#{@zone} \
                      --tier=STANDARD \
                      --file-share=name="NFSvol",capacity=1TB \
                      --network=name="default",reserved-ip-range="10.5.0.0/29")
      end
    end

    def filestore_ip
      response = run_or_bomb %(gcloud filestore instances describe reg-test --project=#{@project} --zone=#{@zone} --format='value(networks.ipAddresses)')
      response.delete("\n").split("'")[1]
    end

    def persistent_volume(action)
      pv = { 'apiVersion' => 'v1',
             'kind' => 'PersistentVolume',
             'metadata' => { 'name' => 'fileserver' },
             'spec' => { 'capacity' => { 'storage' => '1T' },
                         'accessModes' => ['ReadWriteMany'],
                         'nfs' => { 'path' => '/NFSvol', 'server' => filestore_ip.to_s } } }

      File.open('pv.yaml', 'w') { |file| file.write(pv.to_yaml) }
      run_or_bomb %(kubectl #{action} -f pv.yaml)
    end

    def persistent_volume_claim(action)
      pvc = { 'apiVersion' => 'v1',
              'kind' => 'PersistentVolumeClaim',
              'metadata' => { 'name' => 'fileserver-claim' },
              'spec' => { 'storageClassName' => '',
                          'accessModes' => ['ReadWriteMany'],
                          'resources' => { 'requests' => { 'storage' => '1G' } } } }

      File.open('pvc.yaml', 'w') { |file| file.write(pvc.to_yaml) }
      run_or_bomb %(kubectl #{action} -f pvc.yaml)
    end
  end
end
