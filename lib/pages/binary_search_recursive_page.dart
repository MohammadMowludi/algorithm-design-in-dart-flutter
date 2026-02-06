import 'package:algorithm_design_in_dart_flutter/bloc/binary_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BinarySearchRecursivePage extends StatefulWidget {
  const BinarySearchRecursivePage({super.key});

  @override
  State<BinarySearchRecursivePage> createState() => _BinarySearchRecursivePageState();
}

class _BinarySearchRecursivePageState extends State<BinarySearchRecursivePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  late BinarySearchBloc _binarySearchBloc;

  @override
  void initState() {
    super.initState();
    _binarySearchBloc = BinarySearchBloc();
    // Automatically generate list on page load
    _binarySearchBloc.add(GenerateListEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _resultController.dispose();
    _binarySearchBloc.close();
    super.dispose();
  }

  void _performSearch() {
    final target = int.tryParse(_searchController.text) ?? -1;
    if (target >= 0) {
      _binarySearchBloc.add(SearchEvent(target));
    }
  }

  String _getResultMessage(BinarySearchState state) {
    if (state is SearchResultFound) {
      return 'Found at index: ${state.index}';
    } else if (state is SearchResultNotFound) {
      return 'Not found';
    } else if (state is BinarySearchError) {
      return 'Error: ${state.message}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جستجوی باینری با روش بازگشتی'),
      ),
      body: BlocProvider(
        create: (_) => _binarySearchBloc,
        child: BlocConsumer<BinarySearchBloc, BinarySearchState>(
          listener: (context, state) {
            if (state is ListGenerated || 
                state is ListSorted || 
                state is SearchResultFound ||
                state is SearchResultNotFound ||
                state is BinarySearchError) {
              _resultController.text = _getResultMessage(state);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Loading indicator
                  if (state is BinarySearchLoading)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(width: 16),
                          Text(state.message),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // List info
                  if (state is ListGenerated || state is ListSorted)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('List size: ${(state as dynamic).list.length}'),
                            Text('First 5 elements: ${(state as dynamic).list.take(5).toList()}'),
                            Text('Last 5 elements: ${(state as dynamic).list.length <= 5 ? (state as dynamic).list : (state as dynamic).list.skip((state as dynamic).list.length - 5).toList()}'),
                            const SizedBox(height: 10),
                            if (state is ListSorted)
                              const Text('✓ List is sorted',
                                style: TextStyle(color: Colors.green),
                              ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Search input
                  TextField(
                    controller: _searchController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter number to search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: (state is BinarySearchLoading)
                          ? null
                          : () => _binarySearchBloc.add(GenerateListEvent()),
                        child: const Text('Generate List'),
                      ),
                      ElevatedButton(
                        onPressed: (state is BinarySearchLoading || state is! ListGenerated)
                            ? null
                            : () => _binarySearchBloc.add(SortListEvent()),
                        child: const Text('Sort List'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Search button
                  ElevatedButton(
                    onPressed: (state is BinarySearchLoading)
                        ? null
                        : _performSearch,
                    child: const Text('Search'),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Result
                  TextField(
                    controller: _resultController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Result',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  // Search status
                  if (state is SearchResultFound)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Target: ${state.target} found at index ${state.index}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                  if (state is SearchResultNotFound)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Target: ${state.target} not found in the list',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
