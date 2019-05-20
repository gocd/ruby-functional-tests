#!/usr/bin/env bash

# 4, because that's the number of JVMs we test on currently - 8, 10, 11, 12
# its decided not to test on Java 9 since its already EOL
mod="$((${GO_PIPELINE_COUNTER} % 4))"

function use_jdk() {
    if [ ! -f "${HOME}/.jabba/jabba.sh" ]; then
      curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
    fi
    source "${HOME}/.jabba/jabba.sh"
    jabba install "$1=$2"
    jabba use "$1"
}

if [ "$mod" = "0" ]; then
  # use the system jvm
  true
elif [ "$mod" = "1" ]; then
  use_jdk "openjdk@1.10.0-2" "tgz+https://nexus.gocd.io/repository/s3-mirrors/local/jdk/openjdk-10.0.2_linux-x64_bin.tar.gz"
elif [ "$mod" = "2" ]; then
  use_jdk "openjdk@1.11.0-28" "tgz+https://nexus.gocd.io/repository/s3-mirrors/local/jdk/openjdk-11-28_linux-x64_bin.tar.gz"
elif [ "$mod" = "3" ]; then
  use_jdk "openjdk@1.12.0" "tgz+https://download.java.net/java/GA/jdk12/GPL/openjdk-12_linux-x64_bin.tar.gz"
fi

echo "JAVA_HOME set to : $JAVA_HOME"

exec "$@"
