## Aplicação de Teste - nodeJs / Nest / SSE
## Prisma
## Bull
## Redis
## Hbs

1) Subir os containers
  docker compose --build -d

2) Após subir os containers, acessar o container de aplicação e criar o banco:
  docker compose exec app bash
  npx prisma migrate dev

3) Iniciar o serviço, dentro do container de aplicação
  npm run start:dev

4) Acesso ao banco
  docker compose exec mysql bash
  mysql -uroot -proot nest

5) Aplicação - http://localhost:3000/reports/view
