docker run -d --name=mariadb --restart=always -v /etc/localtime:/etc/localtime:ro -e MYSQL_ROOT_PASSWORD=noly -v /home/tosco/Documentos/MYSQL_db/mariadb:/var/lib/mysql -p 3306:3306 mariadb:latest



docker run -d --restart=always --name myphpadmin -v /etc/localtime:/etc/localtime:ro --link mariadb:db -p 8000:80 phpmyadmin/phpmyadmin





docker run -d -p 8080:80 --name my-apache-php-app -v "$PWD":/var/www/html php:7-apache
