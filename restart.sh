#!/bin/bash -eux

cd /home/isucon/webapp/go/
go build -o isucondition

systemctl restart isucondition.go.service
systemctl restart jiaapi-mock.service
systemctl restart nginx.service