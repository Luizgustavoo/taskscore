import 'package:flutter/material.dart';

class CustomActionCard extends StatelessWidget {
  final String title;
  final int score;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomActionCard({
    super.key,
    required this.title,
    required this.score,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorScore = score == 0
        ? Colors.black
        : score < 0
            ? Colors.red
            : Colors.green.shade700;
    return Card(
      margin: const EdgeInsets.all(5),
      color: isSelected ? Colors.blue[100] : null,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Image.asset('assets/images/coin.png'),
            ),
            const SizedBox(width: 4),
            Text(
              '$score',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorScore,
                fontFamily: 'Poppinss',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
