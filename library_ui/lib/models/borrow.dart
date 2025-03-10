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



class Borrow {
  final int id;
  final int bookId;
  final String username;
final String userId;
final String userEmail;
final String userRole;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Borrow({
    required this.id,
    required this.bookId,
    required this.username,
    required this.userEmail,
    required this.userId,
    required this.userRole,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      id: json['id'],
      bookId: json['book_id'],
      username: json['user_data']['username'],
      userEmail: json['user_data']['email'],
      userId: json['user_data']['id'],
      userRole: json['user_data']['role'],
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

static Future<List<Widget>> getAllBorrows() async {
    try {
      final token = await storage.read(key: "paseto");
      http.Response doneResponse = await http.get(
        Uri.parse('$baseUrl/auth/all-borrows'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      print(doneResponse.body);
      if (doneResponse.statusCode != 200) {
        throw Exception('Failed to get previus borrows');
      }

      
      List<Widget> list = [];
      
      // print(json)?
      if (jsonDecode(doneResponse.body).toString() != "null" &&
          doneResponse.body.isNotEmpty) {
        for (var borrow in jsonDecode(doneResponse.body)) {
          list.add(AdminBorrowCard(borrowData: Borrow.fromJson(borrow)));
        }
      }
      print(list);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

static Future<List<Widget>> getOnGoingBorrows() async {
    try {
      final token = await storage.read(key: "paseto");
      http.Response doneResponse = await http.get(
        Uri.parse('$baseUrl/auth/ongoing-borrows'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (doneResponse.statusCode != 200) {
        throw Exception('Failed to get previus borrows');
      }
      print(jsonDecode(doneResponse.body).toString());
      
      List<Widget> list = [];
      
      // print(json)?
      if (jsonDecode(doneResponse.body).toString() != "null" &&
          doneResponse.body.isNotEmpty) {
        for (var borrow in jsonDecode(doneResponse.body)) {
          list.add(AdminOngoingBorrowCard(borrowData: Borrow.fromJson(borrow)));
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
