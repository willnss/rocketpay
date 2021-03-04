# Rocketpay

Projeto para exercitar os fundamentos básicos em Elixir/Phoenix seguindo a trilha Elixir no evento NLW4 RocketSeat.

## Requisitos
 - Possuir uma instância PostgresSQL (local, remoto ou via container docker/podman)
 - Elixir 1.11.3 (compiled with Erlang/OTP 23) 

## Tecnologias Utilizadas
- Elixir
- Phoenix Framework 
- Ecto
- PostgresSQL

## Instalando Dependências e Executando o Projeto
Para iniciar:
- Instale as dependencias com o comando `mix deps.get`
- Edite o arquivo `config/dev.exs` para apontara instância Postgres
- Execute os migrations para criar a base de dados com `mix ecto.setup`
- Inicie a aplicação executando `mix phx.server`

Em seu navegador acesse [`localhost:4000`](http://localhost:4000)

## Milha Extra adicionada ao projeto
 - Implementado autenticação com base nos usuários do banco de dados e autorização de transaçcões para não permitir que qualquer usuário faça transferência senão da conta dele mesmo
 - Ajuste dos testes devido a autenticação dinâmic e não mais fixa

## Learn more About Phoenix Ecosystem 🥰 

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
