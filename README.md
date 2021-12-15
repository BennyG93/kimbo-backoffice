# Kimbo Backoffice
Backend content managment system for Kimio App (Powered by Strapi)

### Build
```
## Log into Docker AWS CLI v1
aws ecr get-login --no-include-email
docker login -u AWS -p <password> https://522796919834.dkr.ecr.eu-west-1.amazonaws.com

## Log into Docker AWS CLI v2
aws ecr get-login-password | docker login --username AWS --password-stdin https://522796919834.dkr.ecr.eu-west-1.amazonaws.com

## Build and push
docker build -t kimbo-backoffice:latest -f platform/cicd/Dockerfile .
docker tag kimbo-backoffice:latest 522796919834.dkr.ecr.eu-west-1.amazonaws.com/kimbo-backoffice:latest
docker push 522796919834.dkr.ecr.eu-west-1.amazonaws.com/kimbo-backoffice:latest
```

### Run Locally
`docker run --name kimbo-backoffice -p 1337:1337 --env-file=./app/.env kimbo-backoffice:latest`

### Run Dev
```
cd app
yarn install
yarn develop
```

### Digital Ocean
https://backoffice.kimboapp.com/

The app is deployed on the web using Digital Ocean App Platform.
Every push to the `master` branch will trigger a build and deploy.
