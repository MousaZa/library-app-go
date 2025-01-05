import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/books/book_page.dart';
import 'package:sizer/sizer.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, category, required this.bookData});
  final Book bookData;
  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {



  bool _coverHover = false;
  bool _deleteHover = false;
  bool _editHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 18.w,
      width: 40.w,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 18.w,
            width: double.infinity,
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
              borderRadius: BorderRadius.circular(20),
            ),
            // padding: EdgeInsets.all(20),
            
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatefulBuilder(builder: (context,setstate){
                  return Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Container(
                    
                    height: 16.w,
                          width: 10.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                    child: Stack(
                      children: [
                        Image.network(
                          "http://localhost/images/covers/${widget.bookData.id}",
                          height: 16.w,
                          width: 10.w,
                          fit: BoxFit.cover,
                        ),
                        MouseRegion(
                          onEnter: (event) {
                            setstate(() {
                              _coverHover = true;
                            });
                          },
                          onExit: (event) {
                            setstate(() {
                              _coverHover = false;
                            });
                          },
                          child: Container(
                            height: 16.w,
                            width: 10.w,
                            child: MaterialButton(
                              hoverColor: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: _coverHover
                                    ? Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 3.w,
                                      )
                                    : null,
                              ),
                              onPressed: () async {
                                final paseto = await storage.read(key: 'paseto');
                                await getUser().then((value) {
                                  Get.dialog(
                                   BookPage(
                                        bookData: widget.bookData,
                                        userId: int.parse(value["user_id"])),
                                    
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        ],
                    ),
                  ),
                );
                }),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        widget.bookData.title,
                        style:
                            TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.bookData.author,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                        
                      SizedBox(
                        height: 5.w,
                      ),
                     
                      Text(
                        '${widget.bookData.language}, ${widget.bookData.category}',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          // todo: fix 
                         FutureBuilder(future: getLike(widget.bookData.id), builder: (context,snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 2.w,
                              );
                            }
                            return Icon(
                                snapshot.data! ? Icons.favorite :Icons.favorite_border,
                                color: snapshot.data! ? Colors.red : Colors.black,
                                size: 2.w,
                              );}),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            widget.bookData.likes.toString(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                        child: Divider(
                          thickness: 2,
                          height: 2.w,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.front_hand_outlined,
                            size: 2.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            widget.bookData.borrows.toString(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FutureBuilder(future: storage.read(key: "role"), builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return SizedBox();
                  }
                  return Visibility(
                    visible: snapshot.data.toString() != "user",
                    child: StatefulBuilder(builder: (context,setstate){
                                    return  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _deleteHover
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.snackbar('Warning', 'Double tap to delete',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2));
                              },
                              onDoubleTap: () {
                                widget.bookData.delete();
                              },
                              child: MouseRegion(
                                onEnter: (event) {
                                  setstate(() {
                                    _deleteHover = true;
                                  });
                                },
                                onExit: (event) {
                                  setstate(() {
                                    _deleteHover = false;
                                  });
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.black,
                                    size: 2.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _editHover
                                  ? MyColors.lightBrown.withOpacity(0.5)
                                  : Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/edit_book',
                                    arguments: widget.bookData);
                              },
                              child: MouseRegion(
                                onEnter: (event) {
                                  setstate(() {
                                    _editHover = true;
                                  });
                                },
                                onExit: (event) {
                                  setstate(() {
                                    _editHover = false;
                                  });
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                    size: 2.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                                    );
                                   }),
                  )
               ;
                })
               ],
            ),
          ),
          Visibility(
            visible: !widget.bookData.available,
            child: Container(
              height: 1.5.w,
              width: 30.w,
              decoration: BoxDecoration(
                color: MyColors.brown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              ),
              child: Center(
                child: Text("Someone else is diving into this book's pages right now!", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: Colors.white,
                      // letterSpacing: 2,
                    ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
