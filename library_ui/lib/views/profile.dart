import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/models/user.dart';
import 'package:library_ui/views/book_card.dart';
import 'package:library_ui/views/borrow_card.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  final Map<String,dynamic> userData ;
   Profile({super.key, required this.userData});
  // final controller = Get.find<AuthState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5.w,  
                  child: Icon(Icons.person, size: 5.w,),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("#${userData["user_id"]}", style: TextStyle(fontSize: 12.sp),),
                Text(userData["username"], style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                Text(userData["email"], style: TextStyle(fontSize: 12.sp),),
                  ],
                ),
                // Text(, style: TextStyle(fontSize: 20),),
                // IconButton(  
                //   icon: Icon(Icons.delete),
                //   onPressed: ()async {
                //     String? paseto = await storage.read(key: "paseto");
                //     await delete(int.parse(userData["user_id"]),paseto! ).then((value){
                //       if (value == 200) {
                //         Get.snackbar('Account deleted successfully', 'Please login to continue');
                //         storage.delete(key: "paseto");
                //         Get.offAllNamed('/login');
                //       } 
                //     });
                   
                //   },
                // ),
              ],
            ),
            SizedBox(height: 50.h,child: VerticalDivider(width: 5.w,),),
            Expanded(
              child: Column(
                children: [
                  Text('Books borrowed', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Expanded(
                    child: FutureBuilder(
                      future: getBorrowedBooks(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData) return CircularProgressIndicator();
                        if(snapshot.data.length == 0) return Center(child: Text('No books borrowed yet'),);
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return BorrowCard(
                              borrowData: Borrow.fromJson(snapshot.data[index]),
                            );
                          },
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
  );
    }
}