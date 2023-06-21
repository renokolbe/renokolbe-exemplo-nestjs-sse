FROM node:20-slim

## Nao ha necessidade de se fazer a instalacao dentro do repositorio
##RUN npm install express --save
##RUN npm install mysql --save

## Debian 9/stretch moved to archive.debian.org https://unix.stackexchange.com/questions/743839/apt-get-update-failed-to-fetch-debian-amd64-packages-while-building-dockerfile-f
## Forca o Repositorio
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt update 

## Instala o Wait for It
##RUN apt install -y wget netcat
##RUN wget -q -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/v2.2.3/wait-for
##RUN chmod +x /usr/bin/wait-for

## Instala OpenSSL
RUN apt-get install -y openssl

WORKDIR /home/node/app

##COPY . . 
##RUN chmod +x inicia_servico.sh

## Não há nececssidade de expor a Porta
## Conexoes na Porta 3000
##EXPOSE 3000

## Configuracoes node/nest
##RUN npm i -g @nestjs/cli
##RUN nest new nestjs-sse
# RUN npm i typescript --save-dev
# RUN npx tsc --init
# RUN npm i tslint --save-dev
##RUN npx tslint --init
##RUN npm install tslint-config-airbnb ## nao precisa
# RUN npm i -D jest @types/jest ts-node --save-dev
# RUN npm i -D @swc/jest @swc/cli @swc/core
##RUN npx jest --init
# RUN npm i uuid @types/uuid --save-dev
# RUN npm install sequelize reflect-metadata sequelize-typescript 
# RUN npm install sqlite3 

##RUN npm update
## RUN npm test
## Define o usuario NODE como padrão
USER node

##RUN npm update
## Não há ncessidade de executar o comando, pois usaremos o entry-point no compose
CMD ["tail", "-f", "/dev/null"]
