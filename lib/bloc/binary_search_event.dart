part of 'binary_search_bloc.dart';

abstract class BinarySearchEvent {}

class GenerateListEvent extends BinarySearchEvent {
  final int count;
  final int step;

  GenerateListEvent({this.count = 1000000, this.step = 5});
}

class SortListEvent extends BinarySearchEvent {}

class SearchEvent extends BinarySearchEvent {
  final int target;

  SearchEvent(this.target);
}

class ClearResultEvent extends BinarySearchEvent {}
