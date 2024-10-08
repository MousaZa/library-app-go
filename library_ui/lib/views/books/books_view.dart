import 'dart:convert';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/books/book_card.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookFetcher extends StatefulWidget {
  final String search  ;
  final String language ;
  final String category ;

  const BookFetcher({super.key, required this.search, required this.language, required this.category});
  @override
  _BookFetcherState createState() => _BookFetcherState();
}

class _BookFetcherState extends State<BookFetcher> {
  late WebSocketChannel channel;
  List books = [];


  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:9090/books?search=${widget.search}&language=${widget.language}&category=${widget.category}'),
    );

    channel.stream.listen(
      (message) {
        setState(() { 
          books.clear();
          books.addAll(jsonDecode(message));
        });
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
        builder: (context, index) {
          final book = Book.fromJson(books[index]);
          return BookCard(bookData: book);
        },
        itemCount: books.length,
        crossAxisCount: 2,
      );
  }
}
  