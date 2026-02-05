import 'package:flutter/material.dart';
import 'pages/binary_search_recursive_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of algorithm page names (30 total)
  final List<Map<String, dynamic>> _algorithms = [
    {'name': 'جستجوی باینری با روش بازگشتی', 'page': const BinarySearchRecursivePage()},
    {'name': 'الگوریتم ۲', 'page': null},
    {'name': 'الگوریتم ۳', 'page': null},
    {'name': 'الگوریتم ۴', 'page': null},
    {'name': 'الگوریتم ۵', 'page': null},
    {'name': 'الگوریتم ۶', 'page': null},
    {'name': 'الگوریتم ۷', 'page': null},
    {'name': 'الگوریتم ۸', 'page': null},
    {'name': 'الگوریتم ۹', 'page': null},
    {'name': 'الگوریتم ۱۰', 'page': null},
    {'name': 'الگوریتم ۱۱', 'page': null},
    {'name': 'الگوریتم ۱۲', 'page': null},
    {'name': 'الگوریتم ۱۳', 'page': null},
    {'name': 'الگوریتم ۱۴', 'page': null},
    {'name': 'الگوریتم ۱۵', 'page': null},
    {'name': 'الگوریتم ۱۶', 'page': null},
    {'name': 'الگوریتم ۱۷', 'page': null},
    {'name': 'الگوریتم ۱۸', 'page': null},
    {'name': 'الگوریتم ۱۹', 'page': null},
    {'name': 'الگوریتم ۲۰', 'page': null},
    {'name': 'الگوریتم ۲۱', 'page': null},
    {'name': 'الگوریتم ۲۲', 'page': null},
    {'name': 'الگوریتم ۲۳', 'page': null},
    {'name': 'الگوریتم ۲۴', 'page': null},
    {'name': 'الگوریتم ۲۵', 'page': null},
    {'name': 'الگوریتم ۲۶', 'page': null},
    {'name': 'الگوریتم ۲۷', 'page': null},
    {'name': 'الگوریتم ۲۸', 'page': null},
    {'name': 'الگوریتم ۲۹', 'page': null},
    {'name': 'الگوریتم ۳۰', 'page': null},
  ];

  void _navigateToPage(Widget page, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _algorithms.length,
        itemBuilder: (context, index) {
          final algorithm = _algorithms[index];
          final buttonNumber = index + 1;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('$buttonNumber - ${algorithm['name']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: algorithm['page'] != null
                  ? () => _navigateToPage(algorithm['page'], algorithm['name'])
                  : null,
            ),
          );
        },
      ),
    );
  }
}
