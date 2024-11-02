import 'package:flutter/material.dart';

// Node class to represent each node in the linked list
class Node {
  int value;
  Node? next;

  Node(this.value);
}

// LinkedList class to manage the linked list operations
class LinkedList {
  Node? head;

  // Add a new node to the linked list
  void add(int value) {
    Node newNode = Node(value);
    if (head == null) {
      head = newNode;
    } else {
      Node? current = head;
      while (current?.next != null) {
        current = current?.next;
      }
      current?.next = newNode;
    }
  }

  // Remove a node with the given value
  void remove(int value) {
    if (head == null) return;

    if (head?.value == value) {
      head = head?.next;
      return;
    }

    Node? current = head;
    while (current?.next != null) {
      if (current?.next?.value == value) {
        current?.next = current?.next?.next;
        return;
      }
      current = current?.next;
    }
  }
}

// Widget to visualize the linked list
class LinkedListVisualizer extends StatelessWidget {
  final LinkedList linkedList;

  LinkedListVisualizer({required this.linkedList});

  @override
  Widget build(BuildContext context) {
    List<Widget> nodes = [];
    Node? current = linkedList.head;

    // Build the visual representation of the linked list nodes
    while (current != null) {
      nodes.add(_buildNode(current.value));
      if (current.next != null) {
        nodes.add(_buildArrow());
      }
      current = current.next;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: nodes,
    );
  }

  // Build a circular node to represent each linked list node
  Widget _buildNode(int value) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent,
      ),
      child: Text(
        value.toString(),
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  // Build an arrow icon to represent the link between nodes
  Widget _buildArrow() {
    return Icon(
      Icons.arrow_forward,
      color: Colors.black,
    );
  }
}

// Main widget with animation for the linked list
class LinkedListAnimate extends StatefulWidget {
  @override
  _LinkedListAnimateState createState() => _LinkedListAnimateState();
}

class _LinkedListAnimateState extends State<LinkedListAnimate>
    with TickerProviderStateMixin {
  LinkedList _linkedList = LinkedList();
  List<int> _values = [];
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    // Set up the animation controller for node addition/removal
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!);
  }

  // Add a new node to the linked list and trigger animation
  void _addNode(int value) {
    setState(() {
      _values.add(value);
      _linkedList.add(value);
    });
    _controller?.forward(from: 0);
  }

  // Remove a node from the linked list and trigger animation
  void _removeNode(int value) {
    setState(() {
      _values.remove(value);
      _linkedList.remove(value);
    });
    _controller?.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Linked List Animate")),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Display the linked list visualizer
          LinkedListVisualizer(linkedList: _linkedList),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _addNode(_values.length + 1),
                child: Text("Add Node"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () =>
                    _removeNode(_values.isNotEmpty ? _values.last : 0),
                child: Text("Remove Node"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

