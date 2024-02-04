import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:examplebloc/repository/news_repository.dart';

part 'addnews_event.dart';
part 'addnews_state.dart';

class AddnewsBloc extends Bloc<AddnewsEvent, AddnewsState> {
  final NewsRepository newsRepository;

  AddnewsBloc({required this.newsRepository}) : super(AddNewsInitialState()) {
    on<AddnewsInitial>(_addnews);
  }

  _addnews(AddnewsInitial event, Emitter emit) async {
    try {
      // state 1
      emit(AddNewsLoadingState());

      // state 2
      final result = await newsRepository.addNews(
        title: event.title,
        content: event.content,
        date: event.date,
        image: event.image,
      );

      // state 3 if success
      emit(AddNewsSuccessState(message: result));

      await Future.delayed(Duration(seconds: 3));

      emit(AddNewsInitialState());
    } catch (error) {
      //state 3 if error
      emit(AddNewsErrorState(error: 'Error: $error'));
    }
  }
}
