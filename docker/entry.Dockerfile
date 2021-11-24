
# build frontend
FROM node:14-alpine AS frontend-builder
ARG CLIENT_SECRET=RQjR2ODnm6q8yzNTZiaztUdzsanfu3L3TJsEHpOl
COPY ./extern/sast_fresh_cup_frontend /app
WORKDIR /app
RUN yarn install
RUN VUE_APP_API_SECRET=${CLIENT_SECRET} yarn build

FROM nginx:1.21
LABEL author=ChenKS<chenks12138@gmail.com>
COPY --from=frontend-builder /app/dist /www
COPY ./config/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]