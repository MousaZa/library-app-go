
import 'package:bloc/bloc.dart';

sealed class HomeEvent {}

class HomeEventChangePage extends HomeEvent {
  HomeEventChangePage({required this.page});

  final int page;
}

class HomeBloc extends Bloc<HomeEvent, int>{
  HomeBloc() : super(0){
    on<HomeEventChangePage>((event, emit) {
      emit(event.page);
    });
  } 
}