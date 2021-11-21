# build frontend
FROM node:14-alpine AS frontend-builder
COPY ./extern/sast_fresh_cup_frontend /app
WORKDIR /app
RUN yarn install
RUN echo "VUE_APP_API_SECRET=RQjR2ODnm6q8yzNTZiaztUdzsanfu3L3TJsEHpOl" > .env.production
RUN yarn build

FROM nginx:1.21
COPY --from=frontend-builder /app/dist /www
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]