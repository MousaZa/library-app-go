import 'package:flutter/material.dart';
import 'package:library_ui/models/book.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key, required this.bookData});
  final Book bookData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Image.network(bookData.coverURL),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('# ${bookData.id}', style: TextStyle(fontSize: 18,),),
                Text(bookData.title, style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold),),
                Text(bookData.author, style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.book_outlined, size: 30,color: Colors.black54,), 
                    SizedBox(width: 10,),
                    Text(bookData.category, style: TextStyle(fontSize: 18,),),
                    SizedBox(width: 20,),
                     Icon(Icons.language, size: 30,color: Colors.black54,), 
                    SizedBox(width: 10,),
                    Text(bookData.language, style: TextStyle(fontSize: 18,),),
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(width: MediaQuery.of(context).size.width * .4,child: Text(bookData.summary,maxLines: 10,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}