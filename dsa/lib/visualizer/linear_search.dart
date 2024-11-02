import 'package:flutter/material.dart';

void main() {
  runApp(LinearSearchVisualizer());
}

class LinearSearchVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Search Visualizer',
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

  void _performLinearSearch() {
    _array = _controller.text.split(',').map(int.parse).toList();
    _target = 5; // Set your target value here for testing
    _result = '';
    _highlightIndex = -1;
    setState(() {
      _isSearching = true; // Start searching
    });

    // Start the search process asynchronously
    Future.delayed(Duration.zero, () {
      linearSearch(_array, _target!);
    });
  }

  Future<void> linearSearch(List<int> arr, int target) async {
    for (int i = 0; i < arr.length; i++) {
      // Highlight the current index for visualization
      setState(() {
        _highlightIndex = i; // Update the highlight index
        _result += 'Checking index: $i, Value: ${arr[i]}\n';
      });

      await Future.delayed(Duration(seconds: 1)); // Pause for a moment for visualization

      if (arr[i] == target) {
        setState(() {
          _result += 'Found target at index: $i\n';
          _isSearching = false; // Stop searching
        });
        return; // Target found
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
        title: Text('Linear Search Visualizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter numbers (comma separated)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSearching ? null : _performLinearSearch,
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
