#!/usr/bin/env bash

# 3, because that's the number of JVMs we test on currently - 11, 12, 13
mod="$((${GO_PIPELINE_COUNTER:-0} % 3))"
# 5, because that's the number of DBs we test are: h2, postgres(9.6, 10, 11 and 12)
 db_mod="$((${GO_PIPELINE_COUNTER:-0} % 5))"

function use_jdk() {
    if [ ! -f "${HOME}/.jabba/jabba.sh" ]; then
      curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
    fi
    source "${HOME}/.jabba/jabba.sh"
    jabba install "$1=$2"
    jabba use "$1"
}


if  [[ "$(uname -s)" = Darwin* ]]; then
  echo "Running on Mac OS so using system Java, not modifying it. Please ensure Java 11/12/13 is installed"

  JAVA_HOME="$(/usr/libexec/java_home)"
  # ensure java is resolvable; it hasn't always been for me (marques)
  # for some reason that I haven't figured out yet
  for wrapper in $(find . -type f -name wrapper.conf); do
    sed -i '' -e '/^wrapper\.java\.command=/d; /^set\.JAVA_HOME/d' "$wrapper"
    printf "wrapper.java.command=%s\nset.JAVA_HOME=%s\n" "$(command -v java)" "$JAVA_HOME" >> "$wrapper"
  done
elif [ "$mod" = "0" ]; then
  use_jdk "openjdk@1.11.0-28" "tgz+https://nexus.gocd.io/repository/s3-mirrors/local/jdk/openjdk-11-28_linux-x64_bin.tar.gz"
elif [ "$mod" = "1" ]; then
  use_jdk "openjdk@1.12.0" "tgz+https://download.java.net/java/GA/jdk12/GPL/openjdk-12_linux-x64_bin.tar.gz"
elif [ "$mod" = "2" ]; then
  use_jdk "openjdk@1.13.0" "tgz+https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz"
fi

echo "JAVA_HOME set to : $JAVA_HOME"

function setup_postgres() {
    /usr/pgsql-$1/bin/initdb /go/.pg-data
    echo "unix_socket_directories = '/tmp'" >> ~/.pg-data/postgresql.conf
    mkdir /go/.pg-data/log
    /usr/pgsql-$1/bin/pg_ctl start -l /go/.pg-data/log/logfile -D /go/.pg-data -w -t 60
    dropdb --if-exists --host=localhost --port=5432 --username go cruise
    createdb --host=localhost --port=5432 --username go cruise
}

if [[ "$db_mod" = "0" ]]; then
    echo "Nothing to do here. Keep using h2."
else
    echo "Copying db.properties to the config"
    cp db.properties config/
    if [[ "$db_mod" = "1" ]]; then
        echo "Running GoCD with postgres 9.6"
        setup_postgres 9.6
    elif [[ "$db_mod" = "2" ]]; then
        echo "Running GoCD with postgres 10"
        setup_postgres 10
    elif [[ "$db_mod" = "3" ]]; then
        echo "Running GoCD with postgres 11"
        setup_postgres 11
    elif [[ "$db_mod" = "4" ]]; then
        echo "Running GoCD with postgres 12"
        setup_postgres 12
    fi
fi
exec "$@"
