class Borrow {

  final int id;
  final int bookId;
  final int userId;
  final String startDate;
  // final bool isReturned;
  final String endDate;
  final String status;

  Borrow({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.startDate,
    // required this.isReturned,
    required this.endDate,
    required this.status,
  });

  factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      id: json['Id'],
      bookId: json['BookId'],
      userId: json['UserId'],
      startDate: json['BorrowDate'],
      endDate: json['ReturnDate'],
      status: json['Status'],
      // isReturned: json['returned'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'BookId': bookId,
    'UserId': userId,
    'BorrowDate': startDate,
    'ReturnDate': endDate,
    // 'returned': isReturned,
    'status': status,
  };

}