import 'package:educaterapia/screens/chat_screen.dart';
import 'package:educaterapia/screens/course_screen.dart';
import 'package:educaterapia/screens/home_screen.dart';
import 'package:educaterapia/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class SectionMenu extends StatelessWidget {
  final int selectedIndex;

  const SectionMenu({
    required this.selectedIndex,
    Key? key,
    required void Function(int index) onItemSelected,
  }) : super(key: key);

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CourseScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white, // Cor de fundo do menu
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
          _buildItem(
            context: context,
            icon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildItem(
            context: context,
            icon: Icons.chat,
            label: 'Chatbot',
            index: 1,
          ),
          _buildItem(
            context: context,
            icon: Icons.play_circle_fill,
            label: 'Cursos',
            index: 2,
          ),
          _buildItem(
            context: context,
            icon: Icons.person,
            label: 'Perfil',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateToPage(context, index),
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
            if (isSelected) // O texto só aparece se estiver selecionado
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

// As telas HomeScreen, ChatScreen, CourseScreen e ProfileScreen devem estar implementadas no seu projeto.
