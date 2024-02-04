part of 'detail_bloc.dart';

@immutable
sealed class DetailState extends Equatable {}

final class DetailInitial extends DetailState {
  @override
  List<Object?> get props => [];
}

final class DetailLoaded extends DetailState {
  final Map news;

  DetailLoaded({required this.news});

  @override
  List<Object?> get props => [news];
}

final class LoadFailed extends DetailState {
  final String msg;

  LoadFailed({this.msg = "Failed to Load News"});
  @override
  List<Object?> get props => [msg];
}

final class NewsDeleted extends DetailState {
  final String title;

  NewsDeleted({required this.title});
  @override
  List<Object?> get props => [title];
}
