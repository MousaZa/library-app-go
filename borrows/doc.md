# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [protos/borrows.proto](#protos_borrows-proto)
    - [AddBorrowRequest](#library-AddBorrowRequest)
    - [Borrow](#library-Borrow)
    - [DeleteBorrowRequest](#library-DeleteBorrowRequest)
    - [GetAllBorrowsRequest](#library-GetAllBorrowsRequest)
    - [GetBookBorrowsRequest](#library-GetBookBorrowsRequest)
    - [GetBorrowsResponse](#library-GetBorrowsResponse)
    - [GetUserBorrowsRequest](#library-GetUserBorrowsRequest)
    - [GetUserOnGoingBorrowsRequest](#library-GetUserOnGoingBorrowsRequest)
    - [MessageResponse](#library-MessageResponse)
    - [UpdateBorrowRequest](#library-UpdateBorrowRequest)
    - [UpdateBorrowResponse](#library-UpdateBorrowResponse)
  
    - [Borrows](#library-Borrows)
  
- [Scalar Value Types](#scalar-value-types)



<a name="protos_borrows-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## protos/borrows.proto



<a name="library-AddBorrowRequest"></a>

### AddBorrowRequest
AddBorrowRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| BookId | [int64](#int64) |  |  |
| UserId | [int64](#int64) |  |  |






<a name="library-Borrow"></a>

### Borrow
Borrow Model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Id | [int64](#int64) |  |  |
| BookId | [int64](#int64) |  |  |
| UserId | [int64](#int64) |  |  |
| BorrowDate | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| ReturnDate | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| Status | [string](#string) |  | example: &#39;done&#39;, &#39;ongoing&#39;, ... |






<a name="library-DeleteBorrowRequest"></a>

### DeleteBorrowRequest
DeleteBorrowRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Id | [int64](#int64) |  |  |






<a name="library-GetAllBorrowsRequest"></a>

### GetAllBorrowsRequest
GetAllBorrowsRequest model






<a name="library-GetBookBorrowsRequest"></a>

### GetBookBorrowsRequest
GetBookBorrowsRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| BookId | [int64](#int64) |  |  |






<a name="library-GetBorrowsResponse"></a>

### GetBorrowsResponse
GetBorrowsResponse model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| borrows | [Borrow](#library-Borrow) | repeated |  |






<a name="library-GetUserBorrowsRequest"></a>

### GetUserBorrowsRequest
GetUserBorrowsRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| UserId | [int64](#int64) |  |  |






<a name="library-GetUserOnGoingBorrowsRequest"></a>

### GetUserOnGoingBorrowsRequest
GetUserOnGoingBorrowsRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| UserId | [int64](#int64) |  |  |






<a name="library-MessageResponse"></a>

### MessageResponse
MessageResponse model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Message | [string](#string) |  |  |






<a name="library-UpdateBorrowRequest"></a>

### UpdateBorrowRequest
UpdateBorrowRequest model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Id | [int64](#int64) |  |  |
| Status | [string](#string) |  |  |






<a name="library-UpdateBorrowResponse"></a>

### UpdateBorrowResponse
UpdateBorrowResponse model


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Message | [string](#string) |  |  |





 

 

 


<a name="library-Borrows"></a>

### Borrows
The Borrows Service

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| AddBorrow | [AddBorrowRequest](#library-AddBorrowRequest) | [MessageResponse](#library-MessageResponse) | AddBorrow creates a new borrow for the user logged in |
| UpdateBorrow | [UpdateBorrowRequest](#library-UpdateBorrowRequest) | [MessageResponse](#library-MessageResponse) | UpdateBorrow is used to update the status of a borrow |
| DeleteBorrow | [DeleteBorrowRequest](#library-DeleteBorrowRequest) | [MessageResponse](#library-MessageResponse) | DeleteBorrow deletes a borrow with a specific ID |
| GetBookBorrows | [GetBookBorrowsRequest](#library-GetBookBorrowsRequest) | [GetBorrowsResponse](#library-GetBorrowsResponse) | GetBookBorrows lists the borrows history for a specific Book |
| GetUserBorrows | [GetUserBorrowsRequest](#library-GetUserBorrowsRequest) | [GetBorrowsResponse](#library-GetBorrowsResponse) | GetUserBorrows lists the borrows history for a specific User |
| GetAllBorrows | [GetAllBorrowsRequest](#library-GetAllBorrowsRequest) | [GetBorrowsResponse](#library-GetBorrowsResponse) | GetAllBorrows lists all the &#39;done&#39; borrows |
| GetUserOnGoingBorrows | [GetUserBorrowsRequest](#library-GetUserBorrowsRequest) | [GetBorrowsResponse](#library-GetBorrowsResponse) | GetUserOnGoingBorrows lists all the borrows that are still active |

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

