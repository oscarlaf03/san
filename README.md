
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

```shell
heroku run ./create_oauth_app.sh -app {nome-do-app-no-heroku}
#  SAN_WEB_UID:  SOME_UID
#  SAN_WEB_SECRET:  SOME_SECRET
```
### Pegando um token

Fazer um POST request no endpoint `/oauth/token` passando no json body

```json
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

```json
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

```json
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

```json
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

```json
curl --location --request GET 'http://localhost:3000/api/v1/organizacoes/5' \
--header 'Authorization: Bearer 00JJOhrteK-pVaxDIPGiw-5MTiGUDOlrrnU2Go7HbtM'
```

**response**

```json
200 OK
```
## Reset da senha

### Novo endpoint POST `api/password_reset` 

#### Body

**exemplo de body válido**
```json
{
    "email": A_VALID_EMAIL_ADREESS,
    "user_type":"user", # "user" ou "beneficiario" seguno sea o caso igual que no login
    "client_id": ID_DO_APP_COMO_NO_LOGIN,
    "client_secret": ID_SECRET_DO_APP_COMO_NO_LOGIN
}

```

**exemplo response 200 OK**

```json
{
    "message": "Instruções para resetar senha enviadas com sucesso ao email: allana@example.com"
}
```

**exemplo response 400 Bad Request**
```json
{
    "message": "Problemas no seu chamado",
    "errors": [
        "'user_type' só pode ser 'user' ou 'beneficiario' e não use222r",
        " 22 não é um endereço válido de email valido",
        "Parâmetros de client_id e/ou client_secret são inválidos"
    ]
}
```



## Confirmação da conta via token e persistência da senha

### Novo endpoint POST `api/confirm-user` 

Este endpoint deve receber o token que foi enviado no email do usuário na hora de criara a sua conta junto com os valores de `password` e `password_confirmation` para validação da senha


#### Body

**exemplo de body válido**
```json

{
    "user_type":"user", # "user" ou "beneficiario" seguno sea o caso igual que no login
    "client_id": ID_DO_APP_COMO_NO_LOGIN,
    "client_secret": ID_SECRET_DO_APP_COMO_NO_LOGIN
    "token": TOKEN_GERADO_POR_DEVISE_ENVIADO_NO_LINK_DO_EMAIL,
    "password": UM_PASSWORD_VALIDO,
    "password_confirmation": UM_PASSWORD_VALIDO
}

```

**exemplo response 200 OK**

```json
{
    "message": "Conta  e senha de   de email test5_confirm@email.com confirmadas com sucesso"
}
```

**exemplo response 400 Bad Request**
```
{
    "message": "Problemas no seu chamado",
    "errors": [
        "O parâmetro: token é obrigatório",
        "O parâmetro: password_confirmation é obrigatório",
        "'user_type' só pode ser 'user' ou 'beneficiario' e não user333",
        "Parâmetros de client_id e/ou client_secret são inválidos",
        "password e password_confirmation têm que ser iguais"
    ]
}
```
## Grupos de  Organizações


Para todos os usuários de  `user_scope` `organizacao` a rota de `api/v1/me` retorna no payload o atributo `org_group` que é uma lista de todas as organizações as que esse usuário tem acesso.

Isto é para considerar o caso de uso de grupos empresarias onde um `user_organizacao`  de uma empresa matriz pode criar `Ticket` apontando   a um Objeto fora da sua própria Organizacão mas dentro do  grupo de empresas as quais ele tem acesso.

O `user_organizacao` que pertence  a uma matriz pode atuar sobre objetos da matriz e das suas subisidiaras. 

O `user_organizacao` que pertence  a uma subsidiria só pode atuar sobre objetos da subsidiaria. 

O `user_group` para um `user_organizacao` de uma `Organizacao` com zero subsidirias é uma lista onde o único elemento é a `Organizacao` do `user_organizacao`  por tanto podem sempre passar como opção ao param de `organizacao_id` uma lista de todas as `id's` dentro do `org_group`

**exemplo do payload /me**

```json

{
    "id": 32,
    "email": "cliente@cliente.com",
    "remember_created_at": null,
    "created_at": "2021-01-31T20:10:08.076-03:00",
    "updated_at": "2021-04-28T18:58:38.391-03:00",
    "organizacao_id": 14,
    "phone": "",
    "first_name": "usuario ",
    "last_name": "teste",
    "confirmed_at": "2021-02-20T21:56:52.460-03:00",
    "confirmation_sent_at": null,
    "user_scope": "organizacao",
    "user_type": "user",
    "full_name": "usuario  teste",
    "org_group": [
        {
            "id": 14,
            "slug": "Customizable",
            "razao_social": "Fontes Comércio EIRELI",
            "cnpj": "52999814000185",
            "created_at": "2021-01-31T20:10:07.625-03:00",
            "updated_at": "2021-04-13T13:01:17.744-03:00",
            "nome_fantasia": "wqwqwesqweqweqwewqeqweqweqw",
            "inscricao_municipal": "51716",
            "inscricao_estadual": "91205191",
            "matriz_id": null
        }
    ],
    "url": "https://san-api-hmg.herokuapp.com/api/v1/users/32"
}
```


