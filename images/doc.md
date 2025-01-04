


# Images API
API for uploading and retrieving image files.
  

## Informations

### Version

1.0.0

## Content negotiation

### URI Schemes
  * http

### Consumes
  * image/jpeg
  * image/jpg
  * image/png
  * application/json
  * multipart/form-data

### Produces
  * image/jpeg
  * image/jpg
  * image/png
  * application/json

## All endpoints

###  books

| Method  | URI     | Name   | Summary |
|---------|---------|--------|---------|
| GET | /images/covers/{id} | [get images covers ID](#get-images-covers-id) | Get a book cover |
| POST | /images/covers/{id} | [post images covers ID](#post-images-covers-id) | Upload a book cover |
  


###  users

| Method  | URI     | Name   | Summary |
|---------|---------|--------|---------|
| GET | /images/avatars/{id} | [get images avatars ID](#get-images-avatars-id) | Get a user avatar |
| POST | /images/avatars/{id} | [post images avatars ID](#post-images-avatars-id) | Upload a user avatar |
  


## Paths

### <span id="get-images-avatars-id"></span> Get a user avatar (*GetImagesAvatarsID*)

```
GET /images/avatars/{id}
```

Retrieves a user avatar image for a specific user ID.

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | User ID |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-images-avatars-id-200) | OK | User avatar image retrieved successfully |  | [schema](#get-images-avatars-id-200-schema) |
| [404](#get-images-avatars-id-404) | Not Found | File not found |  | [schema](#get-images-avatars-id-404-schema) |

#### Responses


##### <span id="get-images-avatars-id-200"></span> 200 - User avatar image retrieved successfully
Status: OK

###### <span id="get-images-avatars-id-200-schema"></span> Schema
   
  



##### <span id="get-images-avatars-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="get-images-avatars-id-404-schema"></span> Schema
   
  

[ImagesNoContent](#images-no-content)

### <span id="get-images-covers-id"></span> Get a book cover (*GetImagesCoversID*)

```
GET /images/covers/{id}
```

Retrieves a book cover image for a specific book ID.

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | Book ID |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-images-covers-id-200) | OK | Book cover image retrieved successfully |  | [schema](#get-images-covers-id-200-schema) |
| [404](#get-images-covers-id-404) | Not Found | File not found |  | [schema](#get-images-covers-id-404-schema) |

#### Responses


##### <span id="get-images-covers-id-200"></span> 200 - Book cover image retrieved successfully
Status: OK

###### <span id="get-images-covers-id-200-schema"></span> Schema
   
  



##### <span id="get-images-covers-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="get-images-covers-id-404-schema"></span> Schema
   
  



### <span id="post-images-avatars-id"></span> Upload a user avatar (*PostImagesAvatarsID*)

```
POST /images/avatars/{id}
```

Uploads a user avatar image for a specific user ID.

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | User ID |
| upload | `formData` | file | `io.ReadCloser` |  | ✓ |  | User avatar image file |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#post-images-avatars-id-201) | Created | Avatar uploaded successfully |  | [schema](#post-images-avatars-id-201-schema) |
| [400](#post-images-avatars-id-400) | Bad Request | Invalid file type |  | [schema](#post-images-avatars-id-400-schema) |
| [500](#post-images-avatars-id-500) | Internal Server Error | Server error |  | [schema](#post-images-avatars-id-500-schema) |

#### Responses


##### <span id="post-images-avatars-id-201"></span> 201 - Avatar uploaded successfully
Status: Created

###### <span id="post-images-avatars-id-201-schema"></span> Schema
   
  

[ImagesNoContent](#images-no-content)

##### <span id="post-images-avatars-id-400"></span> 400 - Invalid file type
Status: Bad Request

###### <span id="post-images-avatars-id-400-schema"></span> Schema
   
  

[ImagesNoContent](#images-no-content)

##### <span id="post-images-avatars-id-500"></span> 500 - Server error
Status: Internal Server Error

###### <span id="post-images-avatars-id-500-schema"></span> Schema
   
  

[ImagesNoContent](#images-no-content)

### <span id="post-images-covers-id"></span> Upload a book cover (*PostImagesCoversID*)

```
POST /images/covers/{id}
```

Uploads a book cover image for a specific book ID.

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | Book ID |
| upload | `formData` | file | `io.ReadCloser` |  | ✓ |  | Book cover image file |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#post-images-covers-id-200) | OK | Successful upload |  | [schema](#post-images-covers-id-200-schema) |
| [400](#post-images-covers-id-400) | Bad Request | Invalid file type |  | [schema](#post-images-covers-id-400-schema) |
| [500](#post-images-covers-id-500) | Internal Server Error | Server error |  | [schema](#post-images-covers-id-500-schema) |

#### Responses


##### <span id="post-images-covers-id-200"></span> 200 - Successful upload
Status: OK

###### <span id="post-images-covers-id-200-schema"></span> Schema
   
  

any

##### <span id="post-images-covers-id-400"></span> 400 - Invalid file type
Status: Bad Request

###### <span id="post-images-covers-id-400-schema"></span> Schema
   
  



##### <span id="post-images-covers-id-500"></span> 500 - Server error
Status: Internal Server Error

###### <span id="post-images-covers-id-500-schema"></span> Schema
   
  

any

## Models

### <span id="images-no-content"></span> imagesNoContent


> Response for no content scenarios.
  



[interface{}](#interface)
