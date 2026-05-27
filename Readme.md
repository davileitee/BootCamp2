

-Para buildar: docker compose up --build -d


-Para rodar : docker compose up

-Para acessar banco de dados usando container Docker diretamente (Execute no PowerShell):
 docker exec -it marmitatech-db mysql -u user -ppassword marmitadb

 Para ver a tabela no MySQL, execute no prompt:
USE marmitadb;
SHOW TABLES;
               OU
Abra o MySql e execute : USE marmitadb;



-Rodando em http://localhost:4000/


  --FLUXO SUBIDA DE CODIGO--
  
-git branch

-git checkout nome-da-branch 

-git pull origin develop
faz alterações

-git add .

-git commit -m "sua mensagem"

-git push origin develop

