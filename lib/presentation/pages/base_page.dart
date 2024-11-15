import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';

class BasePage extends StatelessWidget {
  final Widget bodyContent;
  final int selectedIndex;
  final HomeController _controller;

  const BasePage({
    Key? key,
    required this.bodyContent,
    required this.selectedIndex,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistem Informasi Geografis Desa'),
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Deskripsi'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _controller.onBottomNavTapped,
      ),
    );
  }
}
