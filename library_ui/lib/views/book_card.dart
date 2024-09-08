import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:library_ui/models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key,category, required this.bookData});

  final Book bookData  ;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 350,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.network(bookData.coverURL, width: 200,),
          ), 
          const SizedBox(width: 20),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bookData.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                Text(bookData.author, style: TextStyle(fontSize: 24),),
                Text('${bookData.language}, ${bookData.category}', style: TextStyle(fontSize: 20),),
              ],
            ),
          ), 
          Expanded(child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(bookData.summary,maxLines: 10, overflow: TextOverflow.ellipsis,),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 30,),
                    SizedBox(width: 10,),
                    Text(bookData.likes.toString(), style: TextStyle(fontSize: 30),),
                  ],
                ),
                SizedBox(
                  width: 40,
                  child: Divider(
                    thickness: 2,
                    height: 20,
                  ),
                ),
                 Row(
                  children: [
                    Icon(Icons.front_hand_outlined, size: 30,),
                    SizedBox(width: 10,),
                    Text(bookData.likes.toString(), style: TextStyle(fontSize: 30),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      hoverColor: Colors.red.withOpacity(0.5),
                      onPressed: (){
                        bookData.delete();
                      },
                      child: Center(
                       child:  Icon(Icons.delete_outline,color: Colors.black, size: 40,),
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      hoverColor: Colors.blue.withOpacity(0.5),
                      onPressed: (){
                        Get.toNamed('/edit_book', arguments: bookData);
                      },
                      child: Center(
                       child:  Icon(Icons.edit_outlined,color: Colors.black, size: 40,),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}