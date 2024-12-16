import 'package:flutter/material.dart';
import 'package:educaterapia/screens/chat_screen.dart';
import 'package:educaterapia/screens/course_screen.dart';
import 'package:educaterapia/screens/home_screen.dart';
import 'package:educaterapia/screens/profile_screen.dart';

class SectionMenu extends StatefulWidget {
  @override
  _SectionMenuState createState() => _SectionMenuState();
}

class _SectionMenuState extends State<SectionMenu> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ChatScreen(),
    CourseScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(icon: Icons.home, label: 'Home', index: 0),
            _buildItem(icon: Icons.chat, label: 'Chatbot', index: 1),
            _buildItem(icon: Icons.play_circle_fill, label: 'Cursos', index: 2),
            _buildItem(icon: Icons.person, label: 'Perfil', index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
