FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=slay123!
ENV MYSQL_DATABASE=root
# ENV MYSQL_USER=admin
# ENV MYSQL_PASSWORD=slay123!

COPY ./mysql_setup_userDB.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]