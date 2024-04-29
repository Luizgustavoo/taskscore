import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClassCard extends StatelessWidget {
  const ShimmerClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 100,
            height: 20,
            color: Colors.grey[300],
          ),
        ),
        Divider(
          endIndent: 70,
          indent: 70,
          height: 5,
          thickness: 2,
          color: Colors.blue.shade700,
        ),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            3,
            (_) {
              return Card(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              margin: const EdgeInsets.all(10),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
