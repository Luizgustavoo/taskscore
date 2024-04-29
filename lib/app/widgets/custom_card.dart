import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final int score;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomCard(
      {super.key,
      required this.title,
      required this.score,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: isSelected ? Colors.blue[100] : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onTap,
          leading: const CircleAvatar(
            radius: 25,
            child: Text('AL'),
          ),
          title: Text(title),
          trailing: Text(
            'PT $score',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
