import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/views/borrows/borrow_card.dart';
import 'package:library_ui/views/borrows/ongoing_borrow_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  // final Map<String, dynamic> userData;
  // Profile({super.key, required this.userData});
  // final controller = Get.find<AuthState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getUser(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting) return loadingWidget;
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.lightBrown.withOpacity(0.1),
                  foregroundColor: MyColors.brown,
                  radius: 5.w,
                  child: Icon(
                    Icons.person,
                    size: 5.w,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${snapshot.data["user_id"]}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      snapshot.data["username"],
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data["email"],
                      style: TextStyle(fontSize: 12.sp),
                    ),
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
            SizedBox(
              height: 50.h,
              child: VerticalDivider(
                width: 5.w,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'My borrows',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Expanded(
                  //   child: FutureBuilder(
                  //       future: getOnGoingBorrowedBooks(),
                  //       builder: (context, snapshot) {
                  //         if (snapshot.connectionState ==
                  //             ConnectionState.waiting)
                  //           return CircularProgressIndicator();
                  //         if (!snapshot.hasData)
                  //           return Center(
                  //             child: Text('No books borrowed yet'),
                  //           );
                  //         return OngoingBorrowCard(
                  //           borrowData: Borrow.fromJson(snapshot.data[0]),
                  //         );
                  //       }),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Expanded(
                    child: FutureBuilder(
                        future: Borrow.getBorrows(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          // if (snapshot.data!.length == 0)
                          //   return Center(
                          //     child: Text('No books borrowed yet'),
                          //   );
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return snapshot.data![index];
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
     }
}
