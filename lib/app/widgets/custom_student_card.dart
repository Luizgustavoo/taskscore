import 'package:flutter/material.dart';

class CustomStudentCard extends StatelessWidget {
  final String title;
  final int score;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? avatar;
  final Function()? onLongPress;
  final String heroTag; // Novo parâmetro para o Hero tag

  const CustomStudentCard({
    super.key,
    required this.title,
    required this.score,
    required this.isSelected,
    this.onTap,
    this.onLongPress,
    this.avatar,
    required this.heroTag, // Recebe a tag do Hero
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
        onLongPress: onLongPress,
        minVerticalPadding: 25,
        onTap: onTap,
        leading: Hero(
          // Envolva o avatar em Hero
          tag: heroTag, // Usando a tag do Hero
          child: avatar ?? const CircleAvatar(radius: 25),
        ),
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
