


# Images API
Documentation for Images API
  

## Informations

### Version

1.0.0

## Content negotiation

### URI Schemes
  * http

### Consumes
  * multipart/form-data

### Produces
  * image/jpeg
  * image/png
  * application/json

## All endpoints

###  users

| Method  | URI     | Name   | Summary |
|---------|---------|--------|---------|
| DELETE | /images/avatars/{id} | [delete images avatars ID](#delete-images-avatars-id) | Delete a user avatar image |
| DELETE | /images/covers/{id} | [delete images covers ID](#delete-images-covers-id) | Delete a book cover image |
| GET | /images/avatars/{id} | [get images avatars ID](#get-images-avatars-id) | Get a user avatar image |
| GET | /images/covers/{id} | [get images covers ID](#get-images-covers-id) | Get a book cover image |
| POST | /images/avatars/{id} | [post images avatars ID](#post-images-avatars-id) | Upload a user avatar image |
| POST | /images/covers/{id} | [post images covers ID](#post-images-covers-id) | Upload a book cover image |
  


## Paths

### <span id="delete-images-avatars-id"></span> Delete a user avatar image (*DeleteImagesAvatarsID*)

```
DELETE /images/avatars/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the user avatar |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#delete-images-avatars-id-200) | OK | File deleted |  | [schema](#delete-images-avatars-id-200-schema) |
| [404](#delete-images-avatars-id-404) | Not Found | File not found |  | [schema](#delete-images-avatars-id-404-schema) |
| [500](#delete-images-avatars-id-500) | Internal Server Error | Unable to delete file |  | [schema](#delete-images-avatars-id-500-schema) |

#### Responses


##### <span id="delete-images-avatars-id-200"></span> 200 - File deleted
Status: OK

###### <span id="delete-images-avatars-id-200-schema"></span> Schema

##### <span id="delete-images-avatars-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="delete-images-avatars-id-404-schema"></span> Schema

##### <span id="delete-images-avatars-id-500"></span> 500 - Unable to delete file
Status: Internal Server Error

###### <span id="delete-images-avatars-id-500-schema"></span> Schema

### <span id="delete-images-covers-id"></span> Delete a book cover image (*DeleteImagesCoversID*)

```
DELETE /images/covers/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the book cover |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#delete-images-covers-id-200) | OK | File deleted |  | [schema](#delete-images-covers-id-200-schema) |
| [404](#delete-images-covers-id-404) | Not Found | File not found |  | [schema](#delete-images-covers-id-404-schema) |
| [500](#delete-images-covers-id-500) | Internal Server Error | Unable to delete file |  | [schema](#delete-images-covers-id-500-schema) |

#### Responses


##### <span id="delete-images-covers-id-200"></span> 200 - File deleted
Status: OK

###### <span id="delete-images-covers-id-200-schema"></span> Schema

##### <span id="delete-images-covers-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="delete-images-covers-id-404-schema"></span> Schema

##### <span id="delete-images-covers-id-500"></span> 500 - Unable to delete file
Status: Internal Server Error

###### <span id="delete-images-covers-id-500-schema"></span> Schema

### <span id="get-images-avatars-id"></span> Get a user avatar image (*GetImagesAvatarsID*)

```
GET /images/avatars/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the user avatar |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-images-avatars-id-200) | OK | Image file |  | [schema](#get-images-avatars-id-200-schema) |
| [404](#get-images-avatars-id-404) | Not Found | File not found |  | [schema](#get-images-avatars-id-404-schema) |

#### Responses


##### <span id="get-images-avatars-id-200"></span> 200 - Image file
Status: OK

###### <span id="get-images-avatars-id-200-schema"></span> Schema

##### <span id="get-images-avatars-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="get-images-avatars-id-404-schema"></span> Schema

### <span id="get-images-covers-id"></span> Get a book cover image (*GetImagesCoversID*)

```
GET /images/covers/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the book cover |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [200](#get-images-covers-id-200) | OK | Image file |  | [schema](#get-images-covers-id-200-schema) |
| [404](#get-images-covers-id-404) | Not Found | File not found |  | [schema](#get-images-covers-id-404-schema) |

#### Responses


##### <span id="get-images-covers-id-200"></span> 200 - Image file
Status: OK

###### <span id="get-images-covers-id-200-schema"></span> Schema

##### <span id="get-images-covers-id-404"></span> 404 - File not found
Status: Not Found

###### <span id="get-images-covers-id-404-schema"></span> Schema

### <span id="post-images-avatars-id"></span> Upload a user avatar image (*PostImagesAvatarsID*)

```
POST /images/avatars/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the user avatar |
| upload | `formData` | file | `io.ReadCloser` |  | ✓ |  | Image file to upload |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#post-images-avatars-id-201) | Created | Successfully uploaded |  | [schema](#post-images-avatars-id-201-schema) |
| [400](#post-images-avatars-id-400) | Bad Request | Invalid file type |  | [schema](#post-images-avatars-id-400-schema) |
| [500](#post-images-avatars-id-500) | Internal Server Error | Upload failed |  | [schema](#post-images-avatars-id-500-schema) |

#### Responses


##### <span id="post-images-avatars-id-201"></span> 201 - Successfully uploaded
Status: Created

###### <span id="post-images-avatars-id-201-schema"></span> Schema

##### <span id="post-images-avatars-id-400"></span> 400 - Invalid file type
Status: Bad Request

###### <span id="post-images-avatars-id-400-schema"></span> Schema

##### <span id="post-images-avatars-id-500"></span> 500 - Upload failed
Status: Internal Server Error

###### <span id="post-images-avatars-id-500-schema"></span> Schema

### <span id="post-images-covers-id"></span> Upload a book cover image (*PostImagesCoversID*)

```
POST /images/covers/{id}
```

#### Parameters

| Name | Source | Type | Go type | Separator | Required | Default | Description |
|------|--------|------|---------|-----------| :------: |---------|-------------|
| id | `path` | string | `string` |  | ✓ |  | ID of the book cover |
| upload | `formData` | file | `io.ReadCloser` |  | ✓ |  | Image file to upload |

#### All responses
| Code | Status | Description | Has headers | Schema |
|------|--------|-------------|:-----------:|--------|
| [201](#post-images-covers-id-201) | Created | Successfully uploaded |  | [schema](#post-images-covers-id-201-schema) |
| [400](#post-images-covers-id-400) | Bad Request | Invalid file type |  | [schema](#post-images-covers-id-400-schema) |
| [500](#post-images-covers-id-500) | Internal Server Error | Upload failed |  | [schema](#post-images-covers-id-500-schema) |

#### Responses


##### <span id="post-images-covers-id-201"></span> 201 - Successfully uploaded
Status: Created

###### <span id="post-images-covers-id-201-schema"></span> Schema

##### <span id="post-images-covers-id-400"></span> 400 - Invalid file type
Status: Bad Request

###### <span id="post-images-covers-id-400-schema"></span> Schema

##### <span id="post-images-covers-id-500"></span> 500 - Upload failed
Status: Internal Server Error

###### <span id="post-images-covers-id-500-schema"></span> Schema

## Models
