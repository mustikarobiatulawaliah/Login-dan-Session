part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsEvent extends Equatable {}

final class AddnewsInitial extends AddnewsEvent {
  final String title;
  final String content;
  final String date;
  final File image;

  AddnewsInitial({
    required this.title,
    required this.content,
    required this.date,
    required this.image,
  });

  @override
  List<Object?> get props => [title, content, date, image];
}
