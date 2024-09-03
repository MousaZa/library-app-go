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
	return fileDescriptor_0a5779074719ee4c, []int{0}
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

type AddBorrowResponse struct {
	Message              string   `protobuf:"bytes,1,opt,name=Message,proto3" json:"Message,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *AddBorrowResponse) Reset()         { *m = AddBorrowResponse{} }
func (m *AddBorrowResponse) String() string { return proto.CompactTextString(m) }
func (*AddBorrowResponse) ProtoMessage()    {}
func (*AddBorrowResponse) Descriptor() ([]byte, []int) {
	return fileDescriptor_0a5779074719ee4c, []int{1}
}

func (m *AddBorrowResponse) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_AddBorrowResponse.Unmarshal(m, b)
}
func (m *AddBorrowResponse) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_AddBorrowResponse.Marshal(b, m, deterministic)
}
func (m *AddBorrowResponse) XXX_Merge(src proto.Message) {
	xxx_messageInfo_AddBorrowResponse.Merge(m, src)
}
func (m *AddBorrowResponse) XXX_Size() int {
	return xxx_messageInfo_AddBorrowResponse.Size(m)
}
func (m *AddBorrowResponse) XXX_DiscardUnknown() {
	xxx_messageInfo_AddBorrowResponse.DiscardUnknown(m)
}

var xxx_messageInfo_AddBorrowResponse proto.InternalMessageInfo

func (m *AddBorrowResponse) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

func init() {
	proto.RegisterType((*AddBorrowRequest)(nil), "AddBorrowRequest")
	proto.RegisterType((*AddBorrowResponse)(nil), "AddBorrowResponse")
}

func init() {
	proto.RegisterFile("borrows.proto", fileDescriptor_0a5779074719ee4c)
}

var fileDescriptor_0a5779074719ee4c = []byte{
	// 146 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xe2, 0xe2, 0x4d, 0xca, 0x2f, 0x2a,
	0xca, 0x2f, 0x2f, 0xd6, 0x2b, 0x28, 0xca, 0x2f, 0xc9, 0x57, 0x72, 0xe2, 0x12, 0x70, 0x4c, 0x49,
	0x71, 0x02, 0x8b, 0x05, 0xa5, 0x16, 0x96, 0xa6, 0x16, 0x97, 0x08, 0x89, 0x71, 0xb1, 0x39, 0xe5,
	0xe7, 0x67, 0x7b, 0xa6, 0x48, 0x30, 0x2a, 0x30, 0x6a, 0x30, 0x07, 0x41, 0x79, 0x20, 0xf1, 0xd0,
	0xe2, 0xd4, 0x22, 0xcf, 0x14, 0x09, 0x26, 0x88, 0x38, 0x84, 0xa7, 0xa4, 0xcb, 0x25, 0x88, 0x64,
	0x46, 0x71, 0x41, 0x7e, 0x5e, 0x71, 0xaa, 0x90, 0x04, 0x17, 0xbb, 0x6f, 0x6a, 0x71, 0x71, 0x62,
	0x7a, 0x2a, 0xd8, 0x14, 0xce, 0x20, 0x18, 0xd7, 0xc8, 0x96, 0x8b, 0x1d, 0xa2, 0xb6, 0x58, 0xc8,
	0x88, 0x8b, 0x13, 0xae, 0x53, 0x48, 0x50, 0x0f, 0xdd, 0x25, 0x52, 0x42, 0x7a, 0x18, 0x06, 0x27,
	0xb1, 0x81, 0x1d, 0x6e, 0x0c, 0x08, 0x00, 0x00, 0xff, 0xff, 0xf0, 0x92, 0x97, 0x1d, 0xc9, 0x00,
	0x00, 0x00,
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
	AddBorrow(ctx context.Context, in *AddBorrowRequest, opts ...grpc.CallOption) (*AddBorrowResponse, error)
}

type borrowsClient struct {
	cc grpc.ClientConnInterface
}

func NewBorrowsClient(cc grpc.ClientConnInterface) BorrowsClient {
	return &borrowsClient{cc}
}

func (c *borrowsClient) AddBorrow(ctx context.Context, in *AddBorrowRequest, opts ...grpc.CallOption) (*AddBorrowResponse, error) {
	out := new(AddBorrowResponse)
	err := c.cc.Invoke(ctx, "/Borrows/AddBorrow", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// BorrowsServer is the server API for Borrows service.
type BorrowsServer interface {
	AddBorrow(context.Context, *AddBorrowRequest) (*AddBorrowResponse, error)
}

// UnimplementedBorrowsServer can be embedded to have forward compatible implementations.
type UnimplementedBorrowsServer struct {
}

func (*UnimplementedBorrowsServer) AddBorrow(ctx context.Context, req *AddBorrowRequest) (*AddBorrowResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddBorrow not implemented")
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

var _Borrows_serviceDesc = grpc.ServiceDesc{
	ServiceName: "Borrows",
	HandlerType: (*BorrowsServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "AddBorrow",
			Handler:    _Borrows_AddBorrow_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "borrows.proto",
}
