FROM node:carbon-alpine

# App directory
WORKDIR /usr/src/app

# Move files
COPY . .

# Build, yeah I'm so lazy I like bash, also unzip doesn't always "force"
RUN apk add --no-cache bash unzip && \
    apk add --no-cache --virtual .build-deps alpine-sdk python && \
    npm install  && \
    npm run build && \
    apk del .build-deps


# App runs on port 8080 by default
EXPOSE 8080
CMD [ "npm", "start" ]
