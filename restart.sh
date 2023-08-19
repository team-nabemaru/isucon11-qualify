#!/bin/bash -eux

cd /home/isucon/webapp/go/
go build -o isucondition
cp development/nginx-backend/isucondition.conf /etc/nginx/sites-enabled

systemctl restart isucondition.go.service
systemctl restart jiaapi-mock.service
systemctl restart nginx.service