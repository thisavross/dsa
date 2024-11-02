import 'package:dsa/visualizer/visualizer_home.dart';
import 'package:flutter/material.dart';
import '../chat_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myCurrentIndex = 0; // Moved outside build method to preserve state across rebuilds

  List<Widget> pages = const [
    Visualizer(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 12, 156, 1),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            selectedItemColor: const Color.fromRGBO(53, 114, 239, 1),
            unselectedItemColor: const Color.fromRGBO(5, 12, 156, 1),
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Visualizer"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat Page"),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
