FROM node:carbon-alpine

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app

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
