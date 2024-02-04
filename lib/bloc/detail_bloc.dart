import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:examplebloc/repository/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  NewsRepository newsRepository;
  DetailBloc({required this.newsRepository}) : super(DetailInitial()) {
    on<LoadNewsEvent>(_loadNews);
    on<DeleteNews>(_deletenews);
  }

  _loadNews(LoadNewsEvent event, Emitter emit) async {
    String newsId = event.newsId;

    emit(DetailInitial());

    Map res = await newsRepository.selectNews(newsId);

    log("RESLOAD $res");

    if (res['status'] == true) {
      emit(DetailLoaded(news: res));
    } else {
      emit(LoadFailed(msg: res['msg']));
    }
  }

  _deletenews(DeleteNews event, Emitter emit) async {
    String key = event.id;
    String title = event.title;
    emit(DetailInitial());
    bool res = await newsRepository.deleteNews(key);
    log("OOO $res");
    if (res == true) {
      emit(NewsDeleted(title: title));
    } else {
      Map res = await newsRepository.selectNews(key);

      log("RESLOAD $res");

      if (res['status'] == true) {
        emit(DetailLoaded(news: res));
      } else {
        emit(LoadFailed(msg: res['msg']));
      }
    }
  }
}
