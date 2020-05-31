#!/bin/bash
set -o errexit

if [ -e /workspace/${SA_KEY_FILE} ]; then 
  gcloud auth activate-service-account --key-file=${SA_KEY_FILE};
fi

case "$1" in
    sh|bash)
        set -- "$@"
    ;;
    *)
        set -- bundle exec kitchen "$@"
    ;;
esac

exec "$@"