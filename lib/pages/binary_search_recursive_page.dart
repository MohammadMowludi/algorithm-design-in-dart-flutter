import 'package:flutter/material.dart';

class BinarySearchRecursivePage extends StatefulWidget {
  const BinarySearchRecursivePage({super.key});

  @override
  State<BinarySearchRecursivePage> createState() => _BinarySearchRecursivePageState();
}

class _BinarySearchRecursivePageState extends State<BinarySearchRecursivePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  List<int> _sortedList = List.generate(20, (index) => index * 5); // 0, 5, 10, 15, ...
  
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

  void _performSearch() {
    int target = int.tryParse(_searchController.text) ?? -1;
    int result = _binarySearchRecursive(_sortedList, target, 0, _sortedList.length - 1);
    _resultController.text = result >= 0 ? 'Found at index: $result' : 'Not found';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جستجوی باینری با روش بازگشتی'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sorted List: ${_sortedList.join(', ')}'),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter number to search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _resultController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Result',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
