import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/borrow.dart';

class BorrowHistoryPage extends StatelessWidget {
  const BorrowHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                    child: FutureBuilder(
                        future: Borrow.getAllBorrows(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return loadingWidget;
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
                  )
                ;
  }
}