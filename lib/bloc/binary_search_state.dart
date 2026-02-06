part of 'binary_search_bloc.dart';

abstract class BinarySearchState {}

class BinarySearchInitial extends BinarySearchState {}

class BinarySearchLoading extends BinarySearchState {
  final String message;

  BinarySearchLoading({this.message = 'Processing...'});
}

class ListGenerated extends BinarySearchState {
  final List<int> list;

  ListGenerated(this.list);
}

class ListSorted extends BinarySearchState {
  final List<int> list;

  ListSorted(this.list);
}

class SearchResultFound extends BinarySearchState {
  final int index;
  final int target;
  final List<int> list;

  SearchResultFound({required this.index, required this.target, required this.list});
}

class SearchResultNotFound extends BinarySearchState {
  final int target;
  final List<int> list;

  SearchResultNotFound({required this.target, required this.list});
}

class BinarySearchError extends BinarySearchState {
  final String message;

  BinarySearchError(this.message);
}
