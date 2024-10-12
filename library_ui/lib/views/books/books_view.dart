import 'dart:convert';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/books/book_card.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookFetcher extends StatefulWidget {
  final String search;
  final String language;
  final String category;

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

  @override
  void didUpdateWidget(covariant BookFetcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.search != oldWidget.search ||
        widget.language != oldWidget.language ||
        widget.category != oldWidget.category) {
      
      channel.sink.close(); 
      connectToWebSocket(); 
    }
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://localhost/books?search=${widget.search}&language=${widget.language}&category=${widget.category}'),
    );
    channel.stream.listen(
      (message) {
        setState(() {
          books.clear();
          if(message.toString() != '[]'){
              books.addAll(json.decode(message));
          }
          
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
        if(books.isEmpty)
          return Center(child: CircularProgressIndicator(),);

         final book = Book.fromJson(books[index]);
         return BookCard(bookData: book);
      },
      itemCount: books.length,
      crossAxisCount: 2,
    );
  }
}