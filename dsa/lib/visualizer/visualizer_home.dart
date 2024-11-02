import 'package:dsa/visualizer/binarysearch_page.dart.dart';
import 'package:dsa/visualizer/linear_search.dart';
import 'package:dsa/visualizer/linkedlist.dart';
import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {
  const Visualizer({super.key});

  @override
  State<Visualizer> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Visualizer", style: TextStyle(fontSize:30,fontWeight:FontWeight.w900)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BinarySearchVisualizer()),
                );
              }, child: Text('Binary Search')),
              SizedBox(height: 15,),
              ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LinearSearchVisualizer()),
                );
              }, child: Text("Linear Search")),
               SizedBox(height: 15,),
              ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LinkedListAnimate()),
                );
              }, child: Text("Linkedlist")),
          ],
        ),
    ));
  }
}