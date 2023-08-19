#!/bin/bash -eux

ALP_URL=https://github.com/tkuchiki/alp/releases/download/v1.0.14/alp_linux_amd64.zip

download_alp() {
    if [[ ! -f alp ]];
    then
        curl -L -o alp.zip ${ALP_URL};unzip alp.zip
    fi
}

download_alp