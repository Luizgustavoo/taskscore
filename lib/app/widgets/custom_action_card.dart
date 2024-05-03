import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/models/action_model.dart';

class CustomActionCard extends StatelessWidget {
  final String title;
  final int score;
  final int index;
  final List<ActionModel> actionList;

  const CustomActionCard({
    super.key,
    required this.title,
    required this.score,
    required this.actionList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    RxInt quantity = 0.obs;
    final Color colorScore = score == 0
        ? Colors.black
        : score < 0
            ? Colors.red
            : Colors.green.shade700;

    return Card(
      margin: const EdgeInsets.all(5),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(width: 5),
            Row(
              children: [
                Obx(() {
                  if (quantity.value > 0) {
                    return IconButton(
                      onPressed: () {
                        quantity--;
                        final actionController = Get.put(ActionController());
                        actionController.toggleSelectedActions(
                            index, int.parse(actionList[index].id!), 'remove');
                      },
                      icon: const Icon(
                        Icons.remove,
                        size: 15,
                      ),
                      iconSize: 18,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                Obx(() => Text(
                      quantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    )),
                IconButton(
                  onPressed: () {
                    quantity++;
                    final actionController = Get.put(ActionController());
                    actionController.toggleSelectedActions(
                        index, int.parse(actionList[index].id!), 'add');
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                  iconSize: 18,
                ),
              ],
            ),
          ],
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
