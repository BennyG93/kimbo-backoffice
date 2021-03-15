# Kimbo Backoffice
Backend content managment system for Kimio App (Powered by Strapi)

### Build
```
## Log into Docker
aws ecr get-login --no-include-email
docker login -u AWS -p <password> https://856964256762.dkr.ecr.eu-west-1.amazonaws.com

## Build and push
docker build -t kimbo-backoffice:latest -f platform/docker/Dockerfile .
docker tag kimbo-backoffice:latest 522796919834.dkr.ecr.eu-west-1.amazonaws.com/kimbo-backoffice:latest
docker push 522796919834.dkr.ecr.eu-west-1.amazonaws.com/kimbo-backoffice:latest
```

### Run Production
`docker run --name kimbo-backoffice -p 1337:1337 --env-file=./app/.env kimbo-backoffice:latest`

### Run Dev
```
cd app
yarn install
yarn develop
```
