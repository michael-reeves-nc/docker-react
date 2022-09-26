FROM node:16-alpine AS builder

RUN npm install -g npm

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

#/app/build <==== all the stuff we care about
# FROM statement automatically starts the next section
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default CMD of the nginx container automatically
# starts nginx

