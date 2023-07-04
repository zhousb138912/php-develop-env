mkdir -p /server/data/mongodb6/db
mkdir -p /server/data/mysql8
mkdir -p /server/data/redis
mkdir -p /server/etc/php8.1.19/php.d
mkdir -p /server/log/mongodb6
mkdir -p /server/log/mysql8
mkdir -p /server/log/nginx
mkdir -p /server/log/php8.1
mkdir -p /server/log/redis
mkdir -p /server/www
touch /server/log/mongodb6/mongodb.log
rm /etc/my.cnf
cp /server/etc/mysql/my.cnf /etc/