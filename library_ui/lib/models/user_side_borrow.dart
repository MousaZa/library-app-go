import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/user.dart';
import 'package:library_ui/views/borrows/admin/admin_borrow_card.dart';
import 'package:library_ui/views/borrows/admin/admin_ongoing_borrow_card.dart';
import 'package:library_ui/views/borrows/borrow_card.dart';
import 'package:library_ui/views/borrows/ongoing_borrow_card.dart';



class UserSideBorrow {
  final int id;
  final int bookId;
  final int userId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  UserSideBorrow({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory UserSideBorrow.fromJson(Map<String, dynamic> json) {
    return UserSideBorrow(
      id: json['Id'],
      bookId: json['BookId'],
      userId: json['UserId'],
      startDate: DateTime.fromMillisecondsSinceEpoch(
          json['BorrowDate']['seconds'] * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          json['ReturnDate']['seconds'] * 1000),
      status: json['Status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'BookId': bookId,
        // 'user_data': userData,
        'BorrowDate': startDate,
        'ReturnDate': endDate,
        'status': status,
      };


  static Future<List<Widget>> getBorrows() async {
    try {
      final token = await storage.read(key: "paseto");
      http.Response doneResponse = await http.get(
        Uri.parse('$baseUrl/auth/borrows/user'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (doneResponse.statusCode != 200) {
        throw Exception('Failed to get previus borrows');
      }

      http.Response ongoingResponse = await http.get(
        Uri.parse('$baseUrl/auth/borrows/o/user'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      print(ongoingResponse.body);
      if (ongoingResponse.statusCode != 200) {
        throw Exception('Failed to get ongoing borrows');
      }
      List<Widget> list = [];
      if (ongoingResponse.body.isNotEmpty) {
        list.add(OngoingBorrowCard( 
           borrowData: UserSideBorrow.fromJson(jsonDecode(ongoingResponse.body)[0])));
      }
      // print(json)?
      if (jsonDecode(doneResponse.body).toString() != "null" &&
          doneResponse.body.isNotEmpty) {
        for (var borrow in jsonDecode(doneResponse.body)) {
          list.add(BorrowCard(borrowData: UserSideBorrow.fromJson(borrow)));
        }
      }
      print(list);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
