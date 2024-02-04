part of 'editnews_bloc.dart';

@immutable
sealed class EditnewsState extends Equatable {}

final class EditnewsInitial extends EditnewsState {
  @override
  List<Object?> get props => [];
}

final class LoadingEdit extends EditnewsState {
  @override
  List<Object?> get props => [];
}

final class SuccessEdit extends EditnewsState {
  final String message;

  SuccessEdit({required this.message});
  @override
  List<Object?> get props => [message];
}

final class ErrorEdit extends EditnewsState {
  final String error;

  ErrorEdit({required this.error});
  List<Object?> get props => [error];
}
