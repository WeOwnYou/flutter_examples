part of 'search_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEvent extends SearchPageEvent {
  final String searchString;
  SearchEvent(this.searchString);
  @override
  List<Object?> get props => [searchString];
}

class ChangePage extends SearchPageEvent {
  final int page;
  ChangePage(this.page);
  @override
  List<Object?> get props => [page];
}

class AddKeyword extends SearchPageEvent {
  final String keyword;
  AddKeyword(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

class RemoveKeyword extends SearchPageEvent {}

class SearchById extends SearchPageEvent {
  final String id;
  SearchById(this.id);
  @override
  List<Object?> get props => [id];
}
