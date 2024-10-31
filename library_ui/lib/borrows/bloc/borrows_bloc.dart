import 'package:bloc/bloc.dart';
import 'package:library_ui/models/borrow.dart';
import 'package:library_ui/models/user.dart';


sealed class BorrowsEvent {}

class BorrowsBloc extends Bloc<BorrowsEvent, Borrow> {
  BorrowsBloc() : super(Borrow.empty()) {
    
  }
}
