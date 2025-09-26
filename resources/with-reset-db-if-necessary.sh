#!/bin/bash

# 5, because that's the number of DBs we test are: h2 + 4x postgres versions. See Rakefile name:
db_mod="$((${GO_PIPELINE_COUNTER:-0} % 5))"

if [[ "$db_mod" = "0" ]]; then
    echo "Nothing to do here. Keep using h2."
else
  echo "Copying db.properties to the config"
  cp db.properties config/

  dropdb --if-exists --host=localhost --port=5432 --username go cruise
  createdb --host=localhost --port=5432 --username go cruise
fi

exec "$@"
