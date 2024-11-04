import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/auth/auth.dart';
import 'package:library_ui/auth/bloc/auth_bloc.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    if (context.read<AuthBloc>().state is AuthStateUnauthenticated) {
      return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please login to view profile'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
    } else {
      final state = context.read<AuthBloc>().state as AuthStateAuthenticated;
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.lightGreen,
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
                      "#${state.user.id}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      state.user.name,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.user.email,
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
                        future: Borrow.getBorrows(state.user.token),
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
    }
  
     }
}
