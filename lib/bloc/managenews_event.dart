part of 'managenews_bloc.dart';

@immutable
sealed class ManagenewsEvent extends Equatable {}

final class LoadListNewsEvent extends ManagenewsEvent {
  final String keyword;

  LoadListNewsEvent({this.keyword = ""});

  @override
  List<Object?> get props => [];
}
