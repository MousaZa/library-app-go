import 'package:flutter/material.dart';
import 'package:library_ui/models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key,category, required this.bookData});

  final Book bookData  ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(bookData.imageUrl, width: 200,),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Id: ${bookData.id}'),
                  Text('Title: ${bookData.title}'),
                  Text('Author: ${bookData.author}'),
                  Text('Category: ${bookData.category}'),
                  Text('Language: ${bookData.language}'),
                  Text('Summary: ${bookData.summary}', maxLines: 3, overflow: TextOverflow.ellipsis,),
                  Text('Likes: ${bookData.likes}'),
                  Text('Borrows: ${bookData.borrows}'),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              bookData.delete();
            },
          ),
        ],
      ),
    );
  }
}