import 'package:bloc/bloc.dart';
import 'package:examplebloc/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'managenews_event.dart';
part 'managenews_state.dart';

class ManagenewsBloc extends Bloc<ManagenewsEvent, ManagenewsState> {
  NewsRepository newsRepository;

  ManagenewsBloc({required this.newsRepository}) : super(LoadingNewsState()) {
    on<LoadListNewsEvent>(_listnews);
  }

  _listnews(LoadListNewsEvent event, Emitter emit) async {
    String key = event.keyword;

    emit(LoadingNewsState());
    List res = await newsRepository.getNewsList(key);
    // log(res.toString());
    emit(ListNewsState(news: res, searchText: key));
  }
}
