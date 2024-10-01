// Code generated by protoc-gen-go. DO NOT EDIT.
// source: borrows.proto

package borrows

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	math "math"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

// Borrow Model
type Borrow struct {
	Id                   int64    `protobuf:"varint,1,opt,name=Id,proto3" json:"Id,omitempty"`
	BookId               int64    `protobuf:"varint,2,opt,name=BookId,proto3" json:"BookId,omitempty"`
	UserId               int64    `protobuf:"varint,3,opt,name=UserId,proto3" json:"UserId,omitempty"`
	BorrowDate           string   `protobuf:"bytes,4,opt,name=BorrowDate,proto3" json:"BorrowDate,omitempty"`
	ReturnDate           string   `protobuf:"bytes,5,opt,name=ReturnDate,proto3" json:"ReturnDate,omitempty"`
	Status               string   `protobuf:"bytes,6,opt,name=Status,proto3" json:"Status,omitempty"`
	Returned             bool     `protobuf:"varint,7,opt,name=Returned,proto3" json:"Returned,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Borrow) Reset()         { *m = Borrow{} }
func (m *Borrow) String() string { return proto.CompactTextString(m) }
func (*Borrow) ProtoMessage()    {}
func (*Borrow) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{0}
}

func (m *Borrow) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Borrow.Unmarshal(m, b)
}
func (m *Borrow) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Borrow.Marshal(b, m, deterministic)
}
func (m *Borrow) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Borrow.Merge(m, src)
}
func (m *Borrow) XXX_Size() int {
	return xxx_messageInfo_Borrow.Size(m)
}
func (m *Borrow) XXX_DiscardUnknown() {
	xxx_messageInfo_Borrow.DiscardUnknown(m)
}

var xxx_messageInfo_Borrow proto.InternalMessageInfo

func (m *Borrow) GetId() int64 {
	if m != nil {
		return m.Id
	}
	return 0
}

func (m *Borrow) GetBookId() int64 {
	if m != nil {
		return m.BookId
	}
	return 0
}

func (m *Borrow) GetUserId() int64 {
	if m != nil {
		return m.UserId
	}
	return 0
}

func (m *Borrow) GetBorrowDate() string {
	if m != nil {
		return m.BorrowDate
	}
	return ""
}

func (m *Borrow) GetReturnDate() string {
	if m != nil {
		return m.ReturnDate
	}
	return ""
}

func (m *Borrow) GetStatus() string {
	if m != nil {
		return m.Status
	}
	return ""
}

func (m *Borrow) GetReturned() bool {
	if m != nil {
		return m.Returned
	}
	return false
}

type MessageResponse struct {
	Message              string   `protobuf:"bytes,1,opt,name=Message,proto3" json:"Message,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *MessageResponse) Reset()         { *m = MessageResponse{} }
func (m *MessageResponse) String() string { return proto.CompactTextString(m) }
func (*MessageResponse) ProtoMessage()    {}
func (*MessageResponse) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{1}
}

func (m *MessageResponse) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_MessageResponse.Unmarshal(m, b)
}
func (m *MessageResponse) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_MessageResponse.Marshal(b, m, deterministic)
}
func (m *MessageResponse) XXX_Merge(src proto.Message) {
	xxx_messageInfo_MessageResponse.Merge(m, src)
}
func (m *MessageResponse) XXX_Size() int {
	return xxx_messageInfo_MessageResponse.Size(m)
}
func (m *MessageResponse) XXX_DiscardUnknown() {
	xxx_messageInfo_MessageResponse.DiscardUnknown(m)
}

var xxx_messageInfo_MessageResponse proto.InternalMessageInfo

func (m *MessageResponse) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

// ADD
type AddBorrowRequest struct {
	BookId               int64    `protobuf:"varint,1,opt,name=BookId,proto3" json:"BookId,omitempty"`
	UserId               int64    `protobuf:"varint,2,opt,name=UserId,proto3" json:"UserId,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *AddBorrowRequest) Reset()         { *m = AddBorrowRequest{} }
func (m *AddBorrowRequest) String() string { return proto.CompactTextString(m) }
func (*AddBorrowRequest) ProtoMessage()    {}
func (*AddBorrowRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{2}
}

func (m *AddBorrowRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_AddBorrowRequest.Unmarshal(m, b)
}
func (m *AddBorrowRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_AddBorrowRequest.Marshal(b, m, deterministic)
}
func (m *AddBorrowRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_AddBorrowRequest.Merge(m, src)
}
func (m *AddBorrowRequest) XXX_Size() int {
	return xxx_messageInfo_AddBorrowRequest.Size(m)
}
func (m *AddBorrowRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_AddBorrowRequest.DiscardUnknown(m)
}

var xxx_messageInfo_AddBorrowRequest proto.InternalMessageInfo

func (m *AddBorrowRequest) GetBookId() int64 {
	if m != nil {
		return m.BookId
	}
	return 0
}

func (m *AddBorrowRequest) GetUserId() int64 {
	if m != nil {
		return m.UserId
	}
	return 0
}

// UPDATE
type UpdateBorrowRequest struct {
	Id                   int64    `protobuf:"varint,1,opt,name=Id,proto3" json:"Id,omitempty"`
	Status               string   `protobuf:"bytes,2,opt,name=Status,proto3" json:"Status,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *UpdateBorrowRequest) Reset()         { *m = UpdateBorrowRequest{} }
func (m *UpdateBorrowRequest) String() string { return proto.CompactTextString(m) }
func (*UpdateBorrowRequest) ProtoMessage()    {}
func (*UpdateBorrowRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{3}
}

func (m *UpdateBorrowRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_UpdateBorrowRequest.Unmarshal(m, b)
}
func (m *UpdateBorrowRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_UpdateBorrowRequest.Marshal(b, m, deterministic)
}
func (m *UpdateBorrowRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_UpdateBorrowRequest.Merge(m, src)
}
func (m *UpdateBorrowRequest) XXX_Size() int {
	return xxx_messageInfo_UpdateBorrowRequest.Size(m)
}
func (m *UpdateBorrowRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_UpdateBorrowRequest.DiscardUnknown(m)
}

var xxx_messageInfo_UpdateBorrowRequest proto.InternalMessageInfo

func (m *UpdateBorrowRequest) GetId() int64 {
	if m != nil {
		return m.Id
	}
	return 0
}

func (m *UpdateBorrowRequest) GetStatus() string {
	if m != nil {
		return m.Status
	}
	return ""
}

type UpdateBorrowResponse struct {
	Message              string   `protobuf:"bytes,1,opt,name=Message,proto3" json:"Message,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *UpdateBorrowResponse) Reset()         { *m = UpdateBorrowResponse{} }
func (m *UpdateBorrowResponse) String() string { return proto.CompactTextString(m) }
func (*UpdateBorrowResponse) ProtoMessage()    {}
func (*UpdateBorrowResponse) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{4}
}

func (m *UpdateBorrowResponse) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_UpdateBorrowResponse.Unmarshal(m, b)
}
func (m *UpdateBorrowResponse) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_UpdateBorrowResponse.Marshal(b, m, deterministic)
}
func (m *UpdateBorrowResponse) XXX_Merge(src proto.Message) {
	xxx_messageInfo_UpdateBorrowResponse.Merge(m, src)
}
func (m *UpdateBorrowResponse) XXX_Size() int {
	return xxx_messageInfo_UpdateBorrowResponse.Size(m)
}
func (m *UpdateBorrowResponse) XXX_DiscardUnknown() {
	xxx_messageInfo_UpdateBorrowResponse.DiscardUnknown(m)
}

var xxx_messageInfo_UpdateBorrowResponse proto.InternalMessageInfo

func (m *UpdateBorrowResponse) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

// DELETE
type DeleteBorrowRequest struct {
	Id                   int64    `protobuf:"varint,1,opt,name=Id,proto3" json:"Id,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *DeleteBorrowRequest) Reset()         { *m = DeleteBorrowRequest{} }
func (m *DeleteBorrowRequest) String() string { return proto.CompactTextString(m) }
func (*DeleteBorrowRequest) ProtoMessage()    {}
func (*DeleteBorrowRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{5}
}

func (m *DeleteBorrowRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_DeleteBorrowRequest.Unmarshal(m, b)
}
func (m *DeleteBorrowRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_DeleteBorrowRequest.Marshal(b, m, deterministic)
}
func (m *DeleteBorrowRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_DeleteBorrowRequest.Merge(m, src)
}
func (m *DeleteBorrowRequest) XXX_Size() int {
	return xxx_messageInfo_DeleteBorrowRequest.Size(m)
}
func (m *DeleteBorrowRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_DeleteBorrowRequest.DiscardUnknown(m)
}

var xxx_messageInfo_DeleteBorrowRequest proto.InternalMessageInfo

func (m *DeleteBorrowRequest) GetId() int64 {
	if m != nil {
		return m.Id
	}
	return 0
}

// GET
type GetBookBorrowsRequest struct {
	BookId               int64    `protobuf:"varint,1,opt,name=BookId,proto3" json:"BookId,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *GetBookBorrowsRequest) Reset()         { *m = GetBookBorrowsRequest{} }
func (m *GetBookBorrowsRequest) String() string { return proto.CompactTextString(m) }
func (*GetBookBorrowsRequest) ProtoMessage()    {}
func (*GetBookBorrowsRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{6}
}

func (m *GetBookBorrowsRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetBookBorrowsRequest.Unmarshal(m, b)
}
func (m *GetBookBorrowsRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetBookBorrowsRequest.Marshal(b, m, deterministic)
}
func (m *GetBookBorrowsRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetBookBorrowsRequest.Merge(m, src)
}
func (m *GetBookBorrowsRequest) XXX_Size() int {
	return xxx_messageInfo_GetBookBorrowsRequest.Size(m)
}
func (m *GetBookBorrowsRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_GetBookBorrowsRequest.DiscardUnknown(m)
}

var xxx_messageInfo_GetBookBorrowsRequest proto.InternalMessageInfo

func (m *GetBookBorrowsRequest) GetBookId() int64 {
	if m != nil {
		return m.BookId
	}
	return 0
}

type GetUserBorrowsRequest struct {
	UserId               int64    `protobuf:"varint,1,opt,name=UserId,proto3" json:"UserId,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *GetUserBorrowsRequest) Reset()         { *m = GetUserBorrowsRequest{} }
func (m *GetUserBorrowsRequest) String() string { return proto.CompactTextString(m) }
func (*GetUserBorrowsRequest) ProtoMessage()    {}
func (*GetUserBorrowsRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{7}
}

func (m *GetUserBorrowsRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetUserBorrowsRequest.Unmarshal(m, b)
}
func (m *GetUserBorrowsRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetUserBorrowsRequest.Marshal(b, m, deterministic)
}
func (m *GetUserBorrowsRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetUserBorrowsRequest.Merge(m, src)
}
func (m *GetUserBorrowsRequest) XXX_Size() int {
	return xxx_messageInfo_GetUserBorrowsRequest.Size(m)
}
func (m *GetUserBorrowsRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_GetUserBorrowsRequest.DiscardUnknown(m)
}

var xxx_messageInfo_GetUserBorrowsRequest proto.InternalMessageInfo

func (m *GetUserBorrowsRequest) GetUserId() int64 {
	if m != nil {
		return m.UserId
	}
	return 0
}

type GetUserOnGoingBorrowsRequest struct {
	UserId               int64    `protobuf:"varint,1,opt,name=UserId,proto3" json:"UserId,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *GetUserOnGoingBorrowsRequest) Reset()         { *m = GetUserOnGoingBorrowsRequest{} }
func (m *GetUserOnGoingBorrowsRequest) String() string { return proto.CompactTextString(m) }
func (*GetUserOnGoingBorrowsRequest) ProtoMessage()    {}
func (*GetUserOnGoingBorrowsRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{8}
}

func (m *GetUserOnGoingBorrowsRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetUserOnGoingBorrowsRequest.Unmarshal(m, b)
}
func (m *GetUserOnGoingBorrowsRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetUserOnGoingBorrowsRequest.Marshal(b, m, deterministic)
}
func (m *GetUserOnGoingBorrowsRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetUserOnGoingBorrowsRequest.Merge(m, src)
}
func (m *GetUserOnGoingBorrowsRequest) XXX_Size() int {
	return xxx_messageInfo_GetUserOnGoingBorrowsRequest.Size(m)
}
func (m *GetUserOnGoingBorrowsRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_GetUserOnGoingBorrowsRequest.DiscardUnknown(m)
}

var xxx_messageInfo_GetUserOnGoingBorrowsRequest proto.InternalMessageInfo

func (m *GetUserOnGoingBorrowsRequest) GetUserId() int64 {
	if m != nil {
		return m.UserId
	}
	return 0
}

type GetAllBorrowsRequest struct {
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *GetAllBorrowsRequest) Reset()         { *m = GetAllBorrowsRequest{} }
func (m *GetAllBorrowsRequest) String() string { return proto.CompactTextString(m) }
func (*GetAllBorrowsRequest) ProtoMessage()    {}
func (*GetAllBorrowsRequest) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{9}
}

func (m *GetAllBorrowsRequest) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetAllBorrowsRequest.Unmarshal(m, b)
}
func (m *GetAllBorrowsRequest) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetAllBorrowsRequest.Marshal(b, m, deterministic)
}
func (m *GetAllBorrowsRequest) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetAllBorrowsRequest.Merge(m, src)
}
func (m *GetAllBorrowsRequest) XXX_Size() int {
	return xxx_messageInfo_GetAllBorrowsRequest.Size(m)
}
func (m *GetAllBorrowsRequest) XXX_DiscardUnknown() {
	xxx_messageInfo_GetAllBorrowsRequest.DiscardUnknown(m)
}

var xxx_messageInfo_GetAllBorrowsRequest proto.InternalMessageInfo

type GetBorrowsResponse struct {
	Borrows              []*Borrow `protobuf:"bytes,1,rep,name=borrows,proto3" json:"borrows,omitempty"`
	XXX_NoUnkeyedLiteral struct{}  `json:"-"`
	XXX_unrecognized     []byte    `json:"-"`
	XXX_sizecache        int32     `json:"-"`
}

func (m *GetBorrowsResponse) Reset()         { *m = GetBorrowsResponse{} }
func (m *GetBorrowsResponse) String() string { return proto.CompactTextString(m) }
func (*GetBorrowsResponse) ProtoMessage()    {}
func (*GetBorrowsResponse) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{10}
}

func (m *GetBorrowsResponse) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetBorrowsResponse.Unmarshal(m, b)
}
func (m *GetBorrowsResponse) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetBorrowsResponse.Marshal(b, m, deterministic)
}
func (m *GetBorrowsResponse) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetBorrowsResponse.Merge(m, src)
}
func (m *GetBorrowsResponse) XXX_Size() int {
	return xxx_messageInfo_GetBorrowsResponse.Size(m)
}
func (m *GetBorrowsResponse) XXX_DiscardUnknown() {
	xxx_messageInfo_GetBorrowsResponse.DiscardUnknown(m)
}

var xxx_messageInfo_GetBorrowsResponse proto.InternalMessageInfo

func (m *GetBorrowsResponse) GetBorrows() []*Borrow {
	if m != nil {
		return m.Borrows
	}
	return nil
}

func init() {
	proto.RegisterType((*Borrow)(nil), "Borrow")
	proto.RegisterType((*MessageResponse)(nil), "MessageResponse")
	proto.RegisterType((*AddBorrowRequest)(nil), "AddBorrowRequest")
	proto.RegisterType((*UpdateBorrowRequest)(nil), "UpdateBorrowRequest")
	proto.RegisterType((*UpdateBorrowResponse)(nil), "UpdateBorrowResponse")
	proto.RegisterType((*DeleteBorrowRequest)(nil), "DeleteBorrowRequest")
	proto.RegisterType((*GetBookBorrowsRequest)(nil), "GetBookBorrowsRequest")
	proto.RegisterType((*GetUserBorrowsRequest)(nil), "GetUserBorrowsRequest")
	proto.RegisterType((*GetUserOnGoingBorrowsRequest)(nil), "GetUserOnGoingBorrowsRequest")
	proto.RegisterType((*GetAllBorrowsRequest)(nil), "GetAllBorrowsRequest")
	proto.RegisterType((*GetBorrowsResponse)(nil), "GetBorrowsResponse")
}

func init() {
	proto.RegisterFile("borrows.proto", fileDescriptor_0a5779074719ee4c)
}

var fileDescriptor_0a5779074719ee4c = []byte{
	// 412 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0x94, 0x94, 0xe1, 0x6a, 0xea, 0x30,
	0x14, 0xc7, 0x49, 0x7b, 0xaf, 0xd5, 0x73, 0xaf, 0x5e, 0x6f, 0xac, 0x12, 0x64, 0x8c, 0xae, 0x30,
	0x28, 0x0c, 0x32, 0x71, 0xe0, 0x3e, 0x0c, 0x3f, 0x28, 0x82, 0xf4, 0xc3, 0x18, 0x74, 0xf8, 0x00,
	0x95, 0x04, 0x19, 0x93, 0xd6, 0x35, 0x91, 0xbd, 0xd4, 0x1e, 0x61, 0x0f, 0x37, 0xda, 0x44, 0xd7,
	0x6a, 0x86, 0xdb, 0xc7, 0xf3, 0x3f, 0xf9, 0xa7, 0xe7, 0x7f, 0x7e, 0xa1, 0xd0, 0x5c, 0xa6, 0x59,
	0x96, 0xbe, 0x0a, 0xba, 0xc9, 0x52, 0x99, 0xfa, 0xef, 0x08, 0x6a, 0xd3, 0x42, 0xc1, 0x2d, 0xb0,
	0x42, 0x46, 0x90, 0x87, 0x02, 0x3b, 0xb2, 0x42, 0x86, 0x7b, 0x79, 0x27, 0x7d, 0x0e, 0x19, 0xb1,
	0x0a, 0x4d, 0x57, 0xb9, 0xbe, 0x10, 0x3c, 0x0b, 0x19, 0xb1, 0x95, 0xae, 0x2a, 0x7c, 0x0e, 0xa0,
	0x6e, 0x9a, 0xc5, 0x92, 0x93, 0x5f, 0x1e, 0x0a, 0x1a, 0x51, 0x49, 0xc9, 0xfb, 0x11, 0x97, 0xdb,
	0x2c, 0x29, 0xfa, 0xbf, 0x55, 0xff, 0x53, 0xc9, 0xef, 0x7d, 0x94, 0xb1, 0xdc, 0x0a, 0x52, 0x2b,
	0x7a, 0xba, 0xc2, 0x7d, 0xa8, 0xab, 0x53, 0x9c, 0x11, 0xc7, 0x43, 0x41, 0x3d, 0xda, 0xd7, 0xfe,
	0x15, 0xfc, 0xbb, 0xe7, 0x42, 0xc4, 0x2b, 0x1e, 0x71, 0xb1, 0x49, 0x13, 0xc1, 0x31, 0x01, 0x47,
	0x4b, 0x45, 0x96, 0x46, 0xb4, 0x2b, 0xfd, 0x29, 0xb4, 0x27, 0x8c, 0xa9, 0x89, 0x22, 0xfe, 0xb2,
	0xe5, 0x42, 0x96, 0x42, 0xa2, 0x2f, 0x42, 0x5a, 0xe5, 0x90, 0xfe, 0x18, 0x3a, 0x8b, 0x0d, 0x8b,
	0x25, 0xaf, 0x5e, 0x63, 0xd8, 0x9d, 0xce, 0x62, 0x95, 0xb3, 0xf8, 0x03, 0x70, 0xab, 0xf6, 0x93,
	0x43, 0x5f, 0x42, 0x67, 0xc6, 0xd7, 0xfc, 0xc4, 0x07, 0xfd, 0x6b, 0xe8, 0xce, 0xb9, 0xcc, 0x87,
	0x57, 0xe7, 0xc4, 0x89, 0x80, 0xda, 0x90, 0xa7, 0x3a, 0x36, 0xe8, 0xe4, 0xa8, 0x92, 0x7c, 0x04,
	0x67, 0xda, 0xf0, 0x90, 0xcc, 0xd3, 0xa7, 0x64, 0xf5, 0x4d, 0x5f, 0x0f, 0xdc, 0x39, 0x97, 0x93,
	0xf5, 0xba, 0x7a, 0xde, 0xbf, 0x05, 0x5c, 0x4c, 0xac, 0x45, 0xbd, 0x88, 0x0b, 0x70, 0xf4, 0x03,
	0x25, 0xc8, 0xb3, 0x83, 0x3f, 0x43, 0x87, 0xea, 0xe0, 0x3b, 0x7d, 0xf8, 0x66, 0x83, 0xa3, 0x6d,
	0x78, 0x00, 0x8d, 0x3d, 0x52, 0xfc, 0x9f, 0x1e, 0xe2, 0xed, 0xb7, 0xe9, 0xe1, 0xf3, 0x18, 0xc1,
	0xdf, 0x32, 0x01, 0xec, 0x52, 0x03, 0x4f, 0xb3, 0xaf, 0xcc, 0x01, 0xbb, 0xd4, 0x80, 0xc5, 0xe0,
	0x1b, 0x43, 0xab, 0x0a, 0x06, 0xf7, 0xa8, 0x91, 0x54, 0xbf, 0x43, 0x0d, 0xfb, 0x50, 0xf6, 0x12,
	0x26, 0x65, 0x3f, 0xe6, 0x66, 0xb6, 0xdf, 0x41, 0xb3, 0xb2, 0x7c, 0xdc, 0xa5, 0x26, 0x18, 0x66,
	0xf3, 0x6c, 0xff, 0x44, 0xaa, 0xc4, 0x7f, 0x34, 0xc2, 0xb2, 0x56, 0xfc, 0x68, 0x6e, 0x3e, 0x02,
	0x00, 0x00, 0xff, 0xff, 0x13, 0xd3, 0x1c, 0x36, 0x79, 0x04, 0x00, 0x00,
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConnInterface

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion6

// BorrowsClient is the client API for Borrows service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type BorrowsClient interface {
	// ADD
	AddBorrow(ctx context.Context, in *AddBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// UPDATE
	UpdateBorrow(ctx context.Context, in *UpdateBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// DELETE
	DeleteBorrow(ctx context.Context, in *DeleteBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// GET
	GetBookBorrows(ctx context.Context, in *GetBookBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	GetUserBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	GetAllBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	GetUserOnGoingBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
}

type borrowsClient struct {
	cc grpc.ClientConnInterface
}

func NewBorrowsClient(cc grpc.ClientConnInterface) BorrowsClient {
	return &borrowsClient{cc}
}

func (c *borrowsClient) AddBorrow(ctx context.Context, in *AddBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, "/Borrows/AddBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) UpdateBorrow(ctx context.Context, in *UpdateBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, "/Borrows/UpdateBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) DeleteBorrow(ctx context.Context, in *DeleteBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, "/Borrows/DeleteBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetBookBorrows(ctx context.Context, in *GetBookBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/Borrows/GetBookBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetUserBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/Borrows/GetUserBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetAllBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/Borrows/GetAllBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetUserOnGoingBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/Borrows/GetUserOnGoingBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	} 
	return out, nil
}

// BorrowsServer is the server API for Borrows service.
type BorrowsServer interface {
	// ADD
	AddBorrow(context.Context, *AddBorrowRequest) (*MessageResponse, error)
	// UPDATE
	UpdateBorrow(context.Context, *UpdateBorrowRequest) (*MessageResponse, error)
	// DELETE
	DeleteBorrow(context.Context, *DeleteBorrowRequest) (*MessageResponse, error)
	// GET
	GetBookBorrows(context.Context, *GetBookBorrowsRequest) (*GetBorrowsResponse, error)
	GetUserBorrows(context.Context, *GetUserBorrowsRequest) (*GetBorrowsResponse, error)
	GetAllBorrows(context.Context, *GetAllBorrowsRequest) (*GetBorrowsResponse, error)
	GetUserOnGoingBorrows(context.Context, *GetUserBorrowsRequest) (*GetBorrowsResponse, error)
}

// UnimplementedBorrowsServer can be embedded to have forward compatible implementations.
type UnimplementedBorrowsServer struct {
}

func (*UnimplementedBorrowsServer) AddBorrow(ctx context.Context, req *AddBorrowRequest) (*MessageResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddBorrow not implemented")
}
func (*UnimplementedBorrowsServer) UpdateBorrow(ctx context.Context, req *UpdateBorrowRequest) (*MessageResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateBorrow not implemented")
}
func (*UnimplementedBorrowsServer) DeleteBorrow(ctx context.Context, req *DeleteBorrowRequest) (*MessageResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method DeleteBorrow not implemented")
}
func (*UnimplementedBorrowsServer) GetBookBorrows(ctx context.Context, req *GetBookBorrowsRequest) (*GetBorrowsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetBookBorrows not implemented")
}
func (*UnimplementedBorrowsServer) GetUserBorrows(ctx context.Context, req *GetUserBorrowsRequest) (*GetBorrowsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetUserBorrows not implemented")
}
func (*UnimplementedBorrowsServer) GetAllBorrows(ctx context.Context, req *GetAllBorrowsRequest) (*GetBorrowsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetAllBorrows not implemented")
}
func (*UnimplementedBorrowsServer) GetUserOnGoingBorrows(ctx context.Context, req *GetUserBorrowsRequest) (*GetBorrowsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetUserOnGoingBorrows not implemented")
}

func RegisterBorrowsServer(s *grpc.Server, srv BorrowsServer) {
	s.RegisterService(&_Borrows_serviceDesc, srv)
}

func _Borrows_AddBorrow_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AddBorrowRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).AddBorrow(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/AddBorrow",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).AddBorrow(ctx, req.(*AddBorrowRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_UpdateBorrow_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UpdateBorrowRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).UpdateBorrow(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/UpdateBorrow",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).UpdateBorrow(ctx, req.(*UpdateBorrowRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_DeleteBorrow_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(DeleteBorrowRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).DeleteBorrow(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/DeleteBorrow",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).DeleteBorrow(ctx, req.(*DeleteBorrowRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_GetBookBorrows_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetBookBorrowsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).GetBookBorrows(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/GetBookBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetBookBorrows(ctx, req.(*GetBookBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_GetUserBorrows_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetUserBorrowsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).GetUserBorrows(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/GetUserBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetUserBorrows(ctx, req.(*GetUserBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_GetAllBorrows_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetAllBorrowsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).GetAllBorrows(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/GetAllBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetAllBorrows(ctx, req.(*GetAllBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_GetUserOnGoingBorrows_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetUserBorrowsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).GetUserOnGoingBorrows(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/Borrows/GetUserOnGoingBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetUserOnGoingBorrows(ctx, req.(*GetUserBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

var _Borrows_serviceDesc = grpc.ServiceDesc{
	ServiceName: "Borrows",
	HandlerType: (*BorrowsServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "AddBorrow",
			Handler:    _Borrows_AddBorrow_Handler,
		},
		{
			MethodName: "UpdateBorrow",
			Handler:    _Borrows_UpdateBorrow_Handler,
		},
		{
			MethodName: "DeleteBorrow",
			Handler:    _Borrows_DeleteBorrow_Handler,
		},
		{
			MethodName: "GetBookBorrows",
			Handler:    _Borrows_GetBookBorrows_Handler,
		},
		{
			MethodName: "GetUserBorrows",
			Handler:    _Borrows_GetUserBorrows_Handler,
		},
		{
			MethodName: "GetAllBorrows",
			Handler:    _Borrows_GetAllBorrows_Handler,
		},
		{
			MethodName: "GetUserOnGoingBorrows",
			Handler:    _Borrows_GetUserOnGoingBorrows_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "borrows.proto",
}
