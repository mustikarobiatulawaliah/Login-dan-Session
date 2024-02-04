part of 'managenews_bloc.dart';

@immutable
sealed class ManagenewsState extends Equatable {}

class LoadingNewsState extends ManagenewsState {
  @override
  List<Object?> get props => [];
}

class ListNewsState extends ManagenewsState {
  final List news;
  final String searchText;
  ListNewsState({required this.news, this.searchText = ""});

  @override
  List<Object?> get props => [news, searchText];
}
