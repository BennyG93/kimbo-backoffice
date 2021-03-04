FROM node:14.15.4-alpine

## Install Strapi
RUN yarn global add strapi@3.4.3

## Make project directory
RUN mkdir /srv/app && chown 1000:1000 -R /srv/app

WORKDIR /srv/app

# Install app dependencies
COPY app/package.json ./
COPY app/yarn.lock ./
RUN yarn install

COPY --chown=1000:1000 app/ ./

RUN yarn build

EXPOSE 1337

CMD [ "yarn", "start" ]
