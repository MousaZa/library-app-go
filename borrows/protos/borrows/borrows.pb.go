// Code generated by protoc-gen-go. DO NOT EDIT.
// source: borrows.proto

package library

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
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
	Id         int64                  `protobuf:"varint,1,opt,name=Id,proto3" json:"Id,omitempty"`
	BookId     int64                  `protobuf:"varint,2,opt,name=BookId,proto3" json:"BookId,omitempty"`
	UserId     int64                  `protobuf:"varint,3,opt,name=UserId,proto3" json:"UserId,omitempty"`
	BorrowDate *timestamppb.Timestamp `protobuf:"bytes,4,opt,name=BorrowDate,proto3" json:"BorrowDate,omitempty"`
	ReturnDate *timestamppb.Timestamp `protobuf:"bytes,5,opt,name=ReturnDate,proto3" json:"ReturnDate,omitempty"`
	// example: 'done', 'ongoing', ...
	Status               string   `protobuf:"bytes,6,opt,name=Status,proto3" json:"Status,omitempty"`
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

func (m *Borrow) GetBorrowDate() *timestamppb.Timestamp {
	if m != nil {
		return m.BorrowDate
	}
	return nil
}

func (m *Borrow) GetReturnDate() *timestamppb.Timestamp {
	if m != nil {
		return m.ReturnDate
	}
	return nil
}

func (m *Borrow) GetStatus() string {
	if m != nil {
		return m.Status
	}
	return ""
}

// MessageResponse model
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

// AddBorrowRequest model
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

// UpdateBorrowRequest model
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

// UpdateBorrowResponse model
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

// DeleteBorrowRequest model
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

// GetBookBorrowsRequest model
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

// GetUserBorrowsRequest model
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

// GetUserOnGoingBorrowsRequest model
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

// GetAllBorrowsRequest model
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

// GetBorrowsResponse model
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
	proto.RegisterType((*Borrow)(nil), "library.Borrow")
	proto.RegisterType((*MessageResponse)(nil), "library.MessageResponse")
	proto.RegisterType((*AddBorrowRequest)(nil), "library.AddBorrowRequest")
	proto.RegisterType((*UpdateBorrowRequest)(nil), "library.UpdateBorrowRequest")
	proto.RegisterType((*UpdateBorrowResponse)(nil), "library.UpdateBorrowResponse")
	proto.RegisterType((*DeleteBorrowRequest)(nil), "library.DeleteBorrowRequest")
	proto.RegisterType((*GetBookBorrowsRequest)(nil), "library.GetBookBorrowsRequest")
	proto.RegisterType((*GetUserBorrowsRequest)(nil), "library.GetUserBorrowsRequest")
	proto.RegisterType((*GetUserOnGoingBorrowsRequest)(nil), "library.GetUserOnGoingBorrowsRequest")
	proto.RegisterType((*GetAllBorrowsRequest)(nil), "library.GetAllBorrowsRequest")
	proto.RegisterType((*GetBorrowsResponse)(nil), "library.GetBorrowsResponse")
}

func init() {
	proto.RegisterFile("borrows.proto", fileDescriptor_0a5779074719ee4c)
}

var fileDescriptor_0a5779074719ee4c = []byte{
	// 467 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xa4, 0x54, 0x61, 0x6b, 0xd4, 0x40,
	0x10, 0x65, 0x73, 0xf5, 0x8e, 0x9b, 0xda, 0x56, 0xb7, 0xb5, 0xac, 0x67, 0xd5, 0x23, 0x20, 0x9c,
	0x08, 0x39, 0x39, 0xc1, 0x0f, 0x82, 0x68, 0x4b, 0xf1, 0x38, 0xa4, 0x14, 0x62, 0xfb, 0x03, 0x12,
	0x32, 0x86, 0xc3, 0x34, 0x1b, 0xb3, 0x1b, 0xc4, 0x7f, 0xea, 0x9f, 0xf0, 0x3f, 0x48, 0xb2, 0x9b,
	0xb8, 0x7b, 0x17, 0x13, 0xe1, 0x3e, 0xee, 0xcc, 0x7b, 0x2f, 0x6f, 0xe6, 0x0d, 0x81, 0x83, 0x90,
	0xe7, 0x39, 0xff, 0x21, 0xbc, 0x2c, 0xe7, 0x92, 0xd3, 0x51, 0xb2, 0x0e, 0xf3, 0x20, 0xff, 0x39,
	0x79, 0x1e, 0x73, 0x1e, 0x27, 0x38, 0xaf, 0xca, 0x61, 0xf1, 0x75, 0x2e, 0xd7, 0x77, 0x28, 0x64,
	0x70, 0x97, 0x29, 0xa4, 0xfb, 0x8b, 0xc0, 0xf0, 0xa2, 0xe2, 0xd2, 0x43, 0x70, 0x56, 0x11, 0x23,
	0x53, 0x32, 0x1b, 0xf8, 0xce, 0x2a, 0xa2, 0xa7, 0x65, 0x87, 0x7f, 0x5b, 0x45, 0xcc, 0xa9, 0x6a,
	0xfa, 0x55, 0xd6, 0x6f, 0x05, 0xe6, 0xab, 0x88, 0x0d, 0x54, 0x5d, 0xbd, 0xe8, 0x3b, 0x00, 0xa5,
	0x74, 0x19, 0x48, 0x64, 0x7b, 0x53, 0x32, 0xdb, 0x5f, 0x4c, 0x3c, 0x65, 0xc0, 0xab, 0x0d, 0x78,
	0x37, 0xb5, 0x01, 0xdf, 0x40, 0x97, 0x5c, 0x1f, 0x65, 0x91, 0xa7, 0x15, 0xf7, 0x5e, 0x3f, 0xf7,
	0x2f, 0xba, 0xf4, 0xf3, 0x45, 0x06, 0xb2, 0x10, 0x6c, 0x38, 0x25, 0xb3, 0xb1, 0xaf, 0x5f, 0xee,
	0x2b, 0x38, 0xba, 0x42, 0x21, 0x82, 0x18, 0x7d, 0x14, 0x19, 0x4f, 0x05, 0x52, 0x06, 0x23, 0x5d,
	0xaa, 0xe6, 0x1c, 0xfb, 0xf5, 0xd3, 0xbd, 0x80, 0x07, 0xe7, 0x51, 0xa4, 0x1c, 0xf9, 0xf8, 0xbd,
	0x40, 0x21, 0x8d, 0x05, 0x90, 0x7f, 0x2c, 0xc0, 0x31, 0x17, 0xe0, 0xbe, 0x87, 0xe3, 0xdb, 0x2c,
	0x0a, 0x24, 0xda, 0x32, 0x2d, 0x7b, 0xd5, 0x7e, 0x1d, 0xcb, 0xef, 0x6b, 0x38, 0xb1, 0xe9, 0xbd,
	0xa6, 0x5f, 0xc0, 0xf1, 0x25, 0x26, 0xd8, 0xf3, 0x41, 0x77, 0x0e, 0x8f, 0x96, 0x28, 0x4b, 0xf3,
	0x0a, 0x27, 0x7a, 0x06, 0xd4, 0x84, 0x72, 0xaa, 0x6d, 0x82, 0x9e, 0x9c, 0x58, 0x93, 0xbf, 0x85,
	0x33, 0x4d, 0xb8, 0x4e, 0x97, 0x7c, 0x9d, 0xc6, 0xff, 0xc9, 0x3b, 0x85, 0x93, 0x25, 0xca, 0xf3,
	0x24, 0xb1, 0xf1, 0xee, 0x07, 0xa0, 0x95, 0x63, 0x5d, 0xd4, 0x8b, 0x78, 0x09, 0x23, 0x7d, 0xe6,
	0x8c, 0x4c, 0x07, 0xb3, 0xfd, 0xc5, 0x91, 0xa7, 0xef, 0xdc, 0xd3, 0x0b, 0xa8, 0xfb, 0x8b, 0xdf,
	0x7b, 0x30, 0xd2, 0x74, 0xfa, 0x11, 0xc6, 0x4d, 0xb4, 0xf4, 0x71, 0x43, 0xd9, 0x8c, 0x7b, 0xc2,
	0x9a, 0xd6, 0xe6, 0xd9, 0x7c, 0x82, 0xfb, 0x66, 0x32, 0xf4, 0xac, 0x41, 0xb6, 0xe4, 0xdd, 0xad,
	0x63, 0xe6, 0x65, 0xe8, 0xb4, 0xc4, 0xd8, 0xa1, 0x73, 0x05, 0x87, 0x76, 0xa0, 0xf4, 0x59, 0x83,
	0x6d, 0x4d, 0x7a, 0xf2, 0xc4, 0xee, 0xdb, 0x7b, 0x55, 0x72, 0x46, 0xdc, 0xb6, 0xdc, 0xf6, 0x1d,
	0x74, 0xcb, 0x7d, 0x86, 0x03, 0x2b, 0x54, 0xfa, 0xd4, 0x44, 0x6f, 0x85, 0xdd, 0x2d, 0x76, 0x0d,
	0x0f, 0x97, 0x28, 0xed, 0xab, 0xda, 0x49, 0xf0, 0xa6, 0xb9, 0xed, 0x0d, 0xd1, 0x5d, 0x66, 0x0e,
	0x87, 0xd5, 0x3f, 0xea, 0xcd, 0x9f, 0x00, 0x00, 0x00, 0xff, 0xff, 0x16, 0xe3, 0x24, 0xeb, 0x88,
	0x05, 0x00, 0x00,
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
	// AddBorrow creates a new borrow for the user logged in
	AddBorrow(ctx context.Context, in *AddBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// UpdateBorrow is used to update the status of a borrow
	UpdateBorrow(ctx context.Context, in *UpdateBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// DeleteBorrow deletes a borrow with a specific ID
	DeleteBorrow(ctx context.Context, in *DeleteBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error)
	// GetBookBorrows lists the borrows history for a specific Book
	GetBookBorrows(ctx context.Context, in *GetBookBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	// GetUserBorrows lists the borrows history for a specific User
	GetUserBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	// GetAllBorrows lists all the 'done' borrows
	GetAllBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	// GetOnGoingBorrows lists all the active borrows
	GetOnGoingBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error)
	// GetUserOnGoingBorrows lists all the borrows that are still active
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
	err := c.cc.Invoke(ctx, "/library.Borrows/AddBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) UpdateBorrow(ctx context.Context, in *UpdateBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/UpdateBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) DeleteBorrow(ctx context.Context, in *DeleteBorrowRequest, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/DeleteBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetBookBorrows(ctx context.Context, in *GetBookBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/GetBookBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetUserBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/GetUserBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetAllBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/GetAllBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetOnGoingBorrows(ctx context.Context, in *GetAllBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/GetOnGoingBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *borrowsClient) GetUserOnGoingBorrows(ctx context.Context, in *GetUserBorrowsRequest, opts ...grpc.CallOption) (*GetBorrowsResponse, error) {
	out := new(GetBorrowsResponse)
	err := c.cc.Invoke(ctx, "/library.Borrows/GetUserOnGoingBorrows", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// BorrowsServer is the server API for Borrows service.
type BorrowsServer interface {
	// AddBorrow creates a new borrow for the user logged in
	AddBorrow(context.Context, *AddBorrowRequest) (*MessageResponse, error)
	// UpdateBorrow is used to update the status of a borrow
	UpdateBorrow(context.Context, *UpdateBorrowRequest) (*MessageResponse, error)
	// DeleteBorrow deletes a borrow with a specific ID
	DeleteBorrow(context.Context, *DeleteBorrowRequest) (*MessageResponse, error)
	// GetBookBorrows lists the borrows history for a specific Book
	GetBookBorrows(context.Context, *GetBookBorrowsRequest) (*GetBorrowsResponse, error)
	// GetUserBorrows lists the borrows history for a specific User
	GetUserBorrows(context.Context, *GetUserBorrowsRequest) (*GetBorrowsResponse, error)
	// GetAllBorrows lists all the 'done' borrows
	GetAllBorrows(context.Context, *GetAllBorrowsRequest) (*GetBorrowsResponse, error)
	// GetOnGoingBorrows lists all the active borrows
	GetOnGoingBorrows(context.Context, *GetAllBorrowsRequest) (*GetBorrowsResponse, error)
	// GetUserOnGoingBorrows lists all the borrows that are still active
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
func (*UnimplementedBorrowsServer) GetOnGoingBorrows(ctx context.Context, req *GetAllBorrowsRequest) (*GetBorrowsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetOnGoingBorrows not implemented")
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
		FullMethod: "/library.Borrows/AddBorrow",
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
		FullMethod: "/library.Borrows/UpdateBorrow",
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
		FullMethod: "/library.Borrows/DeleteBorrow",
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
		FullMethod: "/library.Borrows/GetBookBorrows",
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
		FullMethod: "/library.Borrows/GetUserBorrows",
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
		FullMethod: "/library.Borrows/GetAllBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetAllBorrows(ctx, req.(*GetAllBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Borrows_GetOnGoingBorrows_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetAllBorrowsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BorrowsServer).GetOnGoingBorrows(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/library.Borrows/GetOnGoingBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetOnGoingBorrows(ctx, req.(*GetAllBorrowsRequest))
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
		FullMethod: "/library.Borrows/GetUserOnGoingBorrows",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BorrowsServer).GetUserOnGoingBorrows(ctx, req.(*GetUserBorrowsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

var _Borrows_serviceDesc = grpc.ServiceDesc{
	ServiceName: "library.Borrows",
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
			MethodName: "GetOnGoingBorrows",
			Handler:    _Borrows_GetOnGoingBorrows_Handler,
		},
		{
			MethodName: "GetUserOnGoingBorrows",
			Handler:    _Borrows_GetUserOnGoingBorrows_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "borrows.proto",
}
