#!/bin/bash -eux

cd /home/isucon/webapp/go/
go build -o isucondition
cp /home/isucon11-qualify/development/nginx-backend/isucondition.conf /etc/nginx/sites-enabled/isucondition.conf
cp /home/isucon11-qualify/development/mysql-backend/mysql.cnf /etc/mysql/mysql.cnf

systemctl restart isucondition.go.service
systemctl restart jiaapi-mock.service
systemctl restart nginx.service
systemctl restart mysqld.service