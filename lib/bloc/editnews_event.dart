part of 'editnews_bloc.dart';

@immutable
sealed class EditnewsEvent extends Equatable {}

final class SetInit extends EditnewsEvent {
  @override
  List<Object?> get props => [];
}

final class ClickEdit extends EditnewsEvent {
  final String id;
  final String title;
  final String content;
  final String date;
  final File? image;

  ClickEdit({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.image,
  });

  @override
  List<Object?> get props => [title, content, date, image];
}
