FROM gocd/gocd-agent-centos-7:v20.8.0

RUN yum install -y centos-release-scl initscripts && \
yum install -y rh-git29 && \
echo source /opt/rh/rh-git29/enable > /etc/profile.d/rh-git29.sh
