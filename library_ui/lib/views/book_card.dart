import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/book_page.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key,category, required this.bookData});
  final Book bookData  ;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool _coverHover = false ;
  bool _deleteHover = false ;
  bool _editHover = false ;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,

      height: 350,
      width: MediaQuery.of(context).size.width * 0.4,
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
            child: Stack(
              children: [
                Image.network(widget.bookData.coverURL, width: 200, height: 300, fit: BoxFit.cover,),
                MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _coverHover = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _coverHover = false;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 300,
                    child: MaterialButton(
                      hoverColor: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: _coverHover ? Icon(Icons.info_outline, color: Colors.white, size: 40,) :
                          null,
                      ),
                      onPressed: (){
                        Get.defaultDialog(
                         content:  BookPage(bookData: widget.bookData),
                         backgroundColor: Colors.white,
                          title: 'book details',  
                        );
                      },
                      ),
                  ),
                ),
              
              ],
            ),
          ), 
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.bookData.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                Text(widget.bookData.author, style: TextStyle(fontSize: 24),),
                SizedBox(height: 100,),
                Text('${widget.bookData.language}, ${widget.bookData.category}', style: TextStyle(fontSize: 20),),
              ],
            ),
          ), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 30,),
                    SizedBox(width: 10,),
                    Text(widget.bookData.likes.toString(), style: TextStyle(fontSize: 30),),
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
                    Text(widget.bookData.likes.toString(), style: TextStyle(fontSize: 30),),
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
                      color:_deleteHover? Colors.red.withOpacity(0.5): Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        // snackbar('Warning', 'Double tap to delete', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, duration: Duration(seconds: 2));
                      },
                      onDoubleTap: (){
                        widget.bookData.delete();
                      },
                      child: MouseRegion(
                        onEnter: (event) {
                          setState(() {
                            _deleteHover = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            _deleteHover = false;
                          });
                        },
                        child:Center(
                           child:  Icon(Icons.delete_outline,color: Colors.black, size: 40,),
                          ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:_editHover? Colors.blue.withOpacity(0.5): Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/edit_book', arguments: widget.bookData);
                      },
                      child: MouseRegion(
                        onEnter: (event) {
                          setState(() { 
                            _editHover = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            _editHover = false;
                          });
                        },
                        child:Center(
                           child:  Icon(Icons.edit_outlined,color: Colors.black, size: 40,),
                          ),
                      ),
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