#!/usr/bin/env bash

eval "$(pyenv init -)"

case "$1" in
    upload)
    source .env && python upload.py $(git ls-files images/* | xargs)
    ;;

    upload-recent)
    source .env && python upload.py $(git diff HEAD^..HEAD --stat | grep images | awk '{print $1 }' | xargs )
    ;;

    download)
    source .env && python get_emojis.py -o images "${SLACK_TEAM}" "${SLACK_TOKEN}"
    ;;

    *)
    echo "Don't know what is '$@'"
    ;;

esac

