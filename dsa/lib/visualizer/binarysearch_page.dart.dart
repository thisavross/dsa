import 'package:flutter/material.dart';

void main() {
  runApp(BinarySearchVisualizer());
}

class BinarySearchVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Search Visualizer',
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<int> _array = [];
  int? _target;
  int _highlightIndex = -1; // For animation highlighting
  String _result = '';
  bool _isSearching = false;

  void _performBinarySearch() {
    _array = _controller.text.split(',').map(int.parse).toList();
    _target = 5; // Set your target value here for testing
    _result = '';
    _highlightIndex = -1;
    setState(() {
      _isSearching = true; // Start searching
    });

    // Start the search process asynchronously
    Future.delayed(Duration.zero, () {
      binarySearch(_array, _target!);
    });
  }

  Future<void> binarySearch(List<int> arr, int target) async {
    int left = 0;
    int right = arr.length - 1;

    while (left <= right) {
      int mid = left + (right - left) ~/ 2;
      
      // Highlight the current middle index for visualization
      setState(() {
        _highlightIndex = mid; // Update the highlight index
        _result += 'Current array: $arr, Searching at index: $mid\n';
      });

      await Future.delayed(Duration(seconds: 1)); // Pause for a moment for visualization

      if (arr[mid] == target) {
        setState(() {
          _result += 'Found target at index: $mid\n';
          _isSearching = false; // Stop searching
        });
        return; // Target found
      }
      if (arr[mid] < target) {
        left = mid + 1; // Search right half
      } else {
        right = mid - 1; // Search left half
      }
    }

    setState(() {
      _result += 'Target not found\n';
      _isSearching = false; // Stop searching
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Search Visualizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter sorted numbers (comma separated)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSearching ? null : _performBinarySearch,
              child: Text('Start Search'),
            ),
            SizedBox(height: 20),
            _array.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _array.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;

                      // Change the color of the container based on whether it's the highlight index
                      Color color = _highlightIndex == index ? Colors.red : Colors.blue;

                      return AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        color: color,
                        alignment: Alignment.center,
                        child: Text(
                          '$value',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  )
                : Container(),
            SizedBox(height: 20),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
