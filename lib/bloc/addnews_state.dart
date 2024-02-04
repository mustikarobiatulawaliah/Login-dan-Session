part of 'addnews_bloc.dart';

@immutable
sealed class AddnewsState extends Equatable {}

final class AddNewsInitialState extends AddnewsState {
  @override
  List<Object> get props => [];
}

class AddNewsLoadingState extends AddnewsState {
  @override
  List<Object> get props => [];
}

class AddNewsSuccessState extends AddnewsState {
  final String message;

  AddNewsSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddNewsErrorState extends AddnewsState {
  final String error;

  AddNewsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
