part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent extends Equatable {}

class LoadNewsEvent extends DetailEvent {
  final String newsId;

  LoadNewsEvent({required this.newsId});

  @override
  List<Object?> get props => [newsId];
}

final class DeleteNews extends DetailEvent {
  final String id;
  final String title;

  DeleteNews({required this.id, required this.title});
  @override
  List<Object?> get props => [id, title];
}
