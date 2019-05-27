FROM gocd/gocd-agent-centos-7:v19.3.0

COPY gcp.repo /etc/yum.repos.d/gcp.repo

RUN yum install -y google-cloud-sdk kubectl
