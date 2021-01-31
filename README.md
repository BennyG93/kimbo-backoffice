# Kimio Backoffice
Backend content managment system for Kimio App (Powered by Strapi)

### Build
`docker build -t kimio-backoffice:latest .`

### Run Production
`docker run --name kimio-backoffice -p 1337:1337 --env-file=./app/.env kimio-backoffice:latest`

### Run Dev
```
cd app
yarn install
yarn develop
```
