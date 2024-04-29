import 'package:flutter/material.dart';

class CustomHomeCard extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final String? imageUrl;

  const CustomHomeCard({super.key, this.title, this.onTap, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size.shortestSide * 0.18;
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              color: const Color(0xFF1C6399),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, // Cor da borda
                width: 2, // Largura da borda
              ),
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  imageUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppinss',
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
