.PHONY: all
all:
	@make reset-logs
	@make restart

.PHONY: reset-logs
reset-logs:
	mv /var/log/nginx/access.log /var/log/nginx/access.log.$(shell date +%Y%m%d-%H%M%S) | : 
	mv /var/log/mysql/mysql-slow.log /var/log/mysql-slow.log.$(shell date +%Y%m%d-%H%M%S) | : 
	@make restart

.PHONY: restart
restart:
	./restart.sh


.PHONY: alp
alp:
	./alp json --file /var/log/nginx/access.log -o count,method,uri,min,avg,max -m "/isu/[\w]+,/api/condition/[\w]+"


.PHONY: mysqldumpslow
mysqldumpslow:
	mysqldumpslow /var/log/mysql/mysql-slow.log