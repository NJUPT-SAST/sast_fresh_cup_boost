ARG PORT=8000
ARG CLIENT_SECRET=RQjR2ODnm6q8yzNTZiaztUdzsanfu3L3TJsEHpOl

FROM php:7.4-fpm
LABEL author=ChenKS<chenks12138@gmail.com>
ENV ADMIN_NAME=admin
ENV ADMIN_EMAIL=sast_fresh_cup@sast.njupt.com
ENV ADMIN_PASSWORD=admin123
ENV DB_HOST=127.0.0.1
ENV DB_PORT=3306
ENV DB_DATABASE=sast_fresh_cup
ENV DB_USERNAME=sast
ENV DB_PASSWORD=sast
ENV APP_ENV=production
ENV APP_DEBUG=false
COPY ./extern/sast_fresh_cup_backend /app
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
WORKDIR /app
RUN install-php-extensions gd zip PDO pdo_mysql @composer-1
RUN composer install
RUN cp .env.example .env
RUN php artisan key:generate
COPY ./docker/backend-entrypoint.sh /entrypoint.sh
EXPOSE ${PORT}
ENTRYPOINT [ "/entrypoint.sh", "$CLIENT_SECRET"]