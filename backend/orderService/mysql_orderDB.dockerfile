FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=slay123!
ENV MYSQL_DATABASE=root

COPY ./mysql_setup_orderDB.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]