#!/usr/bin/env bash

# 3, because that's the number of JVMs we test on currently - 11, 12, 13

mod="$((${GO_PIPELINE_COUNTER} % 3))"

function use_jdk() {
    if [ ! -f "${HOME}/.jabba/jabba.sh" ]; then
      curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
    fi
    source "${HOME}/.jabba/jabba.sh"
    jabba install "$1=$2"
    jabba use "$1"
}


if  [ "$OSTYPE" = "darwin18" ]; then
  echo "Running on Mac OS so using system Java, not modifying it. Please ensure Java 11/12/13 is installed"
elif [ "$mod" = "0" ]; then
  use_jdk "openjdk@1.11.0-28" "tgz+https://nexus.gocd.io/repository/s3-mirrors/local/jdk/openjdk-11-28_linux-x64_bin.tar.gz"
elif [ "$mod" = "1" ]; then
  use_jdk "openjdk@1.12.0" "tgz+https://download.java.net/java/GA/jdk12/GPL/openjdk-12_linux-x64_bin.tar.gz"
elif [ "$mod" = "2" ]; then
  use_jdk "openjdk@1.13.0" "tgz+https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz"
fi

echo "JAVA_HOME set to : $JAVA_HOME"

# 4 - because thats the number of PG version currently tested on - 9.6, 10, 11, 12

if [ "$USE_POSTGRESQL" = "Y" ]; then

  mod="$((${GO_PIPELINE_COUNTER} % 4))"

  if [ "$mod" = "0" ]; then
    PG_VERSION="9.6"
  elif [ "$mod" = "1" ]; then
    PG_VERSION="10"
  elif [ "$mod" = "2" ]; then
    PG_VERSION="11"
  elif [ "$mod" = "3" ]; then
    PG_VERSION="12"
  fi

  /usr/pgsql-$PG_VERSION/bin/initdb /go/.pg-data
  echo "unix_socket_directories = '/tmp'" >> ~/.pg-data/postgresql.conf
  /usr/pgsql-$PG_VERSION/bin/pg_ctl start -l /go/.pg-data/log -D /go/.pg-data -w -t 60

fi


exec "$@"
