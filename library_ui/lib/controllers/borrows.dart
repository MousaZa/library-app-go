import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/models/book.dart';
import 'package:library_ui/models/user.dart';

class BorrowsController extends GetxController{
  var borrows = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBorrows();
    super.onInit();
  }

  void fetchBorrows() async {
    try {
      isLoading(true);
      // var response = await http.get(Uri.parse('http://localhost:8080/borrows'));
      // if (response.statusCode == 200) {
      //   var data = jsonDecode(response.body);
      //   borrows.assignAll(data);
      // }
    } finally {
      isLoading(false);
    }
  }

  Future<String> add(String token, Book bookData) async {
    try {
      var response = await http.post(
        Uri.parse('http://localhost:8080/borrows'),
        body: jsonEncode({'BookId': bookData.id}),
       headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (response.statusCode == 200) { 
        Get.defaultDialog(
            title: "Success", content: Text("Book borrowed successfully"));
        return 'ok';
      }
      Get.defaultDialog(
          title: "An Error Occurred",
          content: Text("An error occurred, please try again")); 
      return 'error';
    } catch (e) {
      return 'error';
    }
  }}