import 'package:flutter_bloc/flutter_bloc.dart';

part 'binary_search_event.dart';
part 'binary_search_state.dart';

class BinarySearchBloc extends Bloc<BinarySearchEvent, BinarySearchState> {
  BinarySearchBloc() : super(BinarySearchInitial()) {
    on<GenerateListEvent>(_onGenerateList);
    on<SortListEvent>(_onSortList);
    on<SearchEvent>(_onSearch);
    on<ClearResultEvent>(_onClearResult);
  }

  int _binarySearchRecursive(List<int> list, int target, int low, int high) {
    if (low > high) {
      return -1;
    }
    int mid = (low + high) ~/ 2;
    if (list[mid] == target) {
      return mid;
    } else if (list[mid] < target) {
      return _binarySearchRecursive(list, target, mid + 1, high);
    } else {
      return _binarySearchRecursive(list, target, low, mid - 1);
    }
  }

  Future<void> _onGenerateList(
    GenerateListEvent event,
    Emitter<BinarySearchState> emit,
  ) async {
    emit(BinarySearchLoading(message: 'Generating list...'));
    
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 1100));
    
    final list = List.generate(event.count, (index) => index * event.step);
    emit(ListGenerated(list));
  }

  Future<void> _onSortList(
    SortListEvent event,
    Emitter<BinarySearchState> emit,
  ) async {
    if (state is ListGenerated) {
      final currentList = (state as ListGenerated).list;
      emit(BinarySearchLoading(message: 'Sorting list...'));
      
      // Simulate async operation
      await Future.delayed(const Duration(milliseconds: 1100));
      
      final sortedList = List<int>.from(currentList)..sort();
      emit(ListSorted(sortedList));
    }
  }

  Future<void> _onSearch(
    SearchEvent event,
    Emitter<BinarySearchState> emit,
  ) async {
    if (state is ListSorted) {
    final currentList = (state as ListSorted).list;
    emit(BinarySearchLoading(message: 'Searching...'));
    
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 1100));
    
    if (currentList.isEmpty) {
      emit(BinarySearchError('Please generate & sort a list first'));
      return;
    }
    
    final result = _binarySearchRecursive(currentList, event.target, 0, currentList.length - 1);
    
    if (result >= 0) {
      emit(SearchResultFound(index: result, target: event.target, list: currentList));
    } else {
      emit(SearchResultNotFound(target: event.target, list: currentList));
    }
    } else {
      emit(BinarySearchError('Please generate & sort a list first'));
    }
  }

  void _onClearResult(
    ClearResultEvent event,
    Emitter<BinarySearchState> emit,
  ) {
    final currentState = state;
    if (currentState is ListGenerated) {
      emit(ListGenerated(currentState.list));
    } else if (currentState is ListSorted) {
      emit(ListSorted(currentState.list));
    }
  }
}
