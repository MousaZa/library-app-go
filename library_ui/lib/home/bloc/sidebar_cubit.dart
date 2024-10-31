import 'package:bloc/bloc.dart';

class SidebarCubit extends Cubit<bool>{
  SidebarCubit() : super(false);

  void toggle() => emit(!state);
}