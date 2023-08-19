#!/bin/bash -eux

ALP_URL=https://github.com/tkuchiki/alp/releases/download/v1.0.14/alp_linux_amd64.zip
DOWNLOAD_MYSQL_CLIENT="sudo apt-get install -y mysql-client"

download_alp() {
    if [[ ! -f alp ]];
    then
        curl -L -o alp.zip ${ALP_URL};unzip alp.zip
    fi
}

download_mysql_client() {
    if ! which mysqldumpslow >& /dev/null;
    then
        eval "${DOWNLOAD_MYSQL_CLIENT}"
    fi
}

download_alp
download_mysql_client