import 'package:flutter/material.dart';

class CustomStudentCard extends StatelessWidget {
  final String title;
  final int score;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? avatar;

  const CustomStudentCard(
      {super.key,
      required this.title,
      required this.score,
      required this.isSelected,
      this.onTap,
      this.avatar});

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
        minVerticalPadding: 25,
        onTap: onTap,
        leading: avatar,
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Poppins', overflow: TextOverflow.ellipsis),
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
