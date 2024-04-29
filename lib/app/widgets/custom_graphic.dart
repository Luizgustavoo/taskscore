import 'package:flutter/material.dart';

class RowGrafh extends StatelessWidget {
  const RowGrafh(
      {super.key,
      required this.largura,
      required this.nomeAluno,
      required this.cor,
      required this.score,
      required this.avatar});

  final double largura;
  final String nomeAluno;
  final Color cor;
  final double score;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: avatar,
                  trailing: Text(
                    '$score',
                    style:
                        const TextStyle(fontFamily: 'Poppinss', fontSize: 13),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: largura * 900,
                            height: 23,
                            decoration: BoxDecoration(
                                color: cor,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Text(
                            nomeAluno,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )),
      ],
    );
  }
}
