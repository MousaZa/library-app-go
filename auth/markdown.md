


# of Auth API
Documentation for Auth API
  

## Informations

### Version

1.0.0

## Content negotiation

### URI Schemes
  * http

### Consumes
  * application/json

### Produces
  * application/json

## All endpoints

###  auth

| Method  | URI     | Name   | Summary |
|---------|---------|--------|---------|
| GET | /auth/list/users | [list users](#list-users) |  |
| POST | /auth/create | [create user](#create-user) |  |
| POST | /auth/delete/{id} | [delete user](#delete-user) |  |
| GET | /auth/user | [get user data](#get-user-data) |  |
| POST | /auth/login | [login](#login) |  |
  


## Paths

### <span id="list-users"></span> list users (*ListUsers*)

```
GET /auth/list/users
```

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#list-users-200) | OK | A list of user data is returned in the response |  | [schema](#list-users-200-schema) |

#### Responses


##### <span id="list-users-200"></span> 200 - A list of user data is returned in the response
Status: OK

###### <span id="list-users-200-schema"></span> Schema
   
  

[][UserResponse](#user-response)

### <span id="create-user"></span> create user (*createUser*)

```
POST /auth/create
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| Body | `body` | [CreateUserRequest](#create-user-request) | `models.CreateUserRequest` | | ✓ | | The User data |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#create-user-201) | Created |  |  | [schema](#create-user-201-schema) |

#### Responses


##### <span id="create-user-201"></span> 201
Status: Created

###### <span id="create-user-201-schema"></span> Schema

### <span id="delete-user"></span> delete user (*deleteUser*)

```
POST /auth/delete/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | the id of the target user |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#delete-user-201) | Created |  |  | [schema](#delete-user-201-schema) |

#### Responses


##### <span id="delete-user-201"></span> 201
Status: Created

###### <span id="delete-user-201-schema"></span> Schema

### <span id="get-user-data"></span> get user data (*getUserData*)

```
GET /auth/user
```

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-user-data-200) | OK | userResponse |  | [schema](#get-user-data-200-schema) |

#### Responses


##### <span id="get-user-data-200"></span> 200 - userResponse
Status: OK

###### <span id="get-user-data-200-schema"></span> Schema
   
  

[UserResponse](#user-response)

### <span id="login"></span> login (*login*)

```
POST /auth/login
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| Body | `body` | [LoginRequest](#login-request) | `models.LoginRequest` | |  | |  |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#login-200) | OK | A token is returned in the response |  | [schema](#login-200-schema) |

#### Responses


##### <span id="login-200"></span> 200 - A token is returned in the response
Status: OK

###### <span id="login-200-schema"></span> Schema

## Models

### <span id="create-user-request"></span> createUserRequest


  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| Email | string| `string` |  | | email |  |
| Password | string| `string` |  | | password |  |
| Username | string| `string` |  | | username |  |



### <span id="login-request"></span> loginRequest


  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| Password | string| `string` |  | | password |  |
| Username | string| `string` |  | | username |  |



### <span id="user-response"></span> userResponse


  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| Email | string| `string` |  | | email |  |
| ID | string| `string` |  | | user id |  |
| Role | string| `string` |  | | role |  |
| Username | string| `string` |  | | username |  |


