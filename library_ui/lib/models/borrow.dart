class Borrow {

  final int id;
  final int bookId;
  final int userId;
  final DateTime startDate;
  // final bool isReturned;
  final DateTime endDate;
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
    // print(json['BorrowDate']['seconds']); 
    return Borrow(
      id: json['Id'],
      bookId: json['BookId'],
      userId: json['UserId'],
      startDate: json['BorrowDate']['seconds'],
      endDate: json['ReturnDate']['seconds'],
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