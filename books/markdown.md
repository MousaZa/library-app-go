


# of Book API
Documentation for Book API
  

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

###  books

| Method  | URI     | Name   | Summary |
|---------|---------|--------|---------|
| POST | /books/like/{id} | [like book](#like-book) |  |
| POST | /books/remove_like/{id} | [remove like](#remove-like) |  |
| POST | /books | [add book](#add-book) |  |
| POST | /books/borrow/{id} | [add borrow](#add-borrow) |  |
| DELETE | /books/{id} | [delete book](#delete-book) |  |
| GET | /books/{id} | [get book](#get-book) |  |
| GET | /books | [get books](#get-books) |  |
| PUT | /books/{id} | [update book](#update-book) |  |
  


## Paths

### <span id="like-book"></span> like book (*LikeBook*)

```
POST /books/like/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | The ID of the book to remove the like |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#like-book-201) | Created |  |  | [schema](#like-book-201-schema) |

#### Responses


##### <span id="like-book-201"></span> 201
Status: Created

###### <span id="like-book-201-schema"></span> Schema

### <span id="remove-like"></span> remove like (*RemoveLike*)

```
POST /books/remove_like/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | The ID of the book to remove the like |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#remove-like-201) | Created |  |  | [schema](#remove-like-201-schema) |

#### Responses


##### <span id="remove-like-201"></span> 201
Status: Created

###### <span id="remove-like-201-schema"></span> Schema

### <span id="add-book"></span> add book (*addBook*)

```
POST /books
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| book | `body` | [Book](#book) | `models.Book` | | ✓ | | The Book data |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#add-book-201) | Created |  |  | [schema](#add-book-201-schema) |

#### Responses


##### <span id="add-book-201"></span> 201
Status: Created

###### <span id="add-book-201-schema"></span> Schema

### <span id="add-borrow"></span> add borrow (*addBorrow*)

```
POST /books/borrow/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | The ID of the book to remove the like |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#add-borrow-201) | Created |  |  | [schema](#add-borrow-201-schema) |

#### Responses


##### <span id="add-borrow-201"></span> 201
Status: Created

###### <span id="add-borrow-201-schema"></span> Schema

### <span id="delete-book"></span> delete book (*deleteBook*)

```
DELETE /books/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | the id of the target book |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#delete-book-201) | Created |  |  | [schema](#delete-book-201-schema) |

#### Responses


##### <span id="delete-book-201"></span> 201
Status: Created

###### <span id="delete-book-201-schema"></span> Schema

### <span id="get-book"></span> get book (*getBook*)

```
GET /books/{id}
```

Returns a book

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | the id of the target book |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-book-200) | OK | A book returns in the response |  | [schema](#get-book-200-schema) |

#### Responses


##### <span id="get-book-200"></span> 200 - A book returns in the response
Status: OK

###### <span id="get-book-200-schema"></span> Schema
   
  

[][Book](#book)

### <span id="get-books"></span> get books (*getBooks*)

```
GET /books
```

Returns a list of books

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-books-200) | OK | A list of books returns in the response |  | [schema](#get-books-200-schema) |

#### Responses


##### <span id="get-books-200"></span> 200 - A list of books returns in the response
Status: OK

###### <span id="get-books-200-schema"></span> Schema
   
  

[Book](#book)

### <span id="update-book"></span> update book (*updateBook*)

```
PUT /books/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | int64 (formatted integer) | `int64` |  | ✓ |  | the id of the target book |
| book | `body` | [Book](#book) | `models.Book` | | ✓ | | The Book data |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#update-book-201) | Created |  |  | [schema](#update-book-201-schema) |

#### Responses


##### <span id="update-book-201"></span> 201
Status: Created

###### <span id="update-book-201-schema"></span> Schema

## Models

### <span id="book"></span> Book


  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| Author | string| `string` |  | |  |  |
| Available | boolean| `bool` |  | |  |  |
| Borrows | int64 (formatted integer)| `int64` |  | |  |  |
| Category | string| `string` |  | |  |  |
| CoverURL | string| `string` |  | |  |  |
| Id | int64 (formatted integer)| `int64` |  | |  |  |
| Language | string| `string` |  | |  |  |
| Likes | int64 (formatted integer)| `int64` |  | |  |  |
| Summary | string| `string` |  | |  |  |
| Title | string| `string` |  | |  |  |


