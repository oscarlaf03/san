
# Core Api  para clientes web e mobile

## Autenticação
Esquema de oauth token via api

### `client_id` e `client_secret`
Cada aplicativo cliente (web ou mobile) tem seus próprios id e secret que são exigidos para obter o token

Pegue os `client_id` e `client_secret` direto app rodando o seguente shell script

```
heroku run ./show_oauth_app.sh -app {nome-do-app-no-heroku}
#  SAN_WEB_UID:  SOME_UID
#  SAN_WEB_SECRET:  SOME_SECRET
```

Caso o seu app cliente não esteja presente pode criá-lo rodando:

```
heroku run ./create_oauth_app.sh -app {nome-do-app-no-heroku}
#  SAN_WEB_UID:  SOME_UID
#  SAN_WEB_SECRET:  SOME_SECRET
```
### Pegando um token

Fazer um POST request no endpoint `/oauth/token` passando no json body
```
{
  "email": "email_do_user_registrado@email.com",
  "password": "123123",
  "user_type": "user", # user_type pode ser "user" ou "beneficiario"
  "grant_type": "password",
  "client_id": "A_VALID_CLIENT_ID",
  "client_secret":"A_VALID_CLIENT_SECRET"
}
```

#### user_type
O  app tem dois models de usuário cuja sessão é gerenciada pelo Devise

**`User`** model representa dois tipos do usuários que gerenciam `Beneficiarios` e/ou `Organizacoes`:
 - o usuário "organizacao" só gerencia usuários da própria `Organizacao`, `Beneficiarios` da própria `Organizacao` e atributos da própria `Organizacao` exemplo: `user.client_user? # true ou false` 
 - o usuário "interno" representa o funcionário da Sanus que gerencia diversas  `organizacoes` e diversos `beneficiarios` exemplo: `user.internal? # true ou false`

Ambos casos de login deste tipo de usuário deve ser feito passando: `"user_type": "user"`

**`Beneficiario`** model representa dois tipos do usuários:
 - o usuário "titular" representa o beneficiario titular do convenio médico exemplo: `beneficiario.titular? # true ou false`
 - o usuário "dependente" representa o beneficiario dependente que tem o convenio mediante um beneficiario titular exemplos: `beneficiario.dependente? # true ou false`


Ambos casos de login deste tipo de usuário deve ser feito passando: `"user_type": "beneficiario"`


**exemplo curl de login de um User**

```
curl --location --request POST 'http://localhost:3000/oauth/token' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "teste@teste.com",
  "user_type": "user",
  "password": "123123",
  "grant_type": "password",
  "client_id": "A_VALID_CLIENT_ID",
  "client_secret":"A_VALID_CLIENT_SECRET"
}'

```

**exemplo curl login Beneficiario**

```
curl --location --request POST 'http://localhost:3000/oauth/token' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "beneficiario_teste@beneficiario.com",
  "user_type": "beneficiario",
  "password": "123123",
  "grant_type": "password",
  "client_id": "A_VALID_CLIENT_ID",
  "client_secret":"A_VALID_CLIENT_SECRET"
}'

```

**exemplo de response**

```
{
    "access_token": "00JJOhrteK-pVaxDIPGiw-5MTiGUDOlrrnU2Go7HbtM",
    "token_type": "Bearer",
    "user_scope": "organizacao",
    "expires_in": 86400,
    "refresh_token": "nu5RAWyUlfkkq39fLVnq0wkK1TgLLDdaTm1AY_Rg6sM",
    "created_at": 1613939644
}

```
O campo **user_scope** determina que tipo de usuário com base as decrições anteriores, com esse dado o front sabe para que página redirecionar o usuário após o login


Agora você pode bater nos endpoints `api/v1`  passando to token como "`Bearer TOKEN`" no header de "`Authorization`"

Seguindo o exemplo do token retornado acima

**exemplo curl de GET request de uma Organizacao**

```
curl --location --request GET 'http://localhost:3000/api/v1/organizacoes/5' \
--header 'Authorization: Bearer 00JJOhrteK-pVaxDIPGiw-5MTiGUDOlrrnU2Go7HbtM'
```

**response**

```
200 OK
```
