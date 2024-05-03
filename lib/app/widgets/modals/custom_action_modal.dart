import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/models/action_model_student.dart';

class CustomActionModal extends StatelessWidget {
  final int? index;
  const CustomActionModal({super.key, required this.actions, this.index});

  final List<ActionModelStudent> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Image.asset('assets/images/coin.png'),
            ),
            const SizedBox(width: 4),
            Text(
              '${actions[index!].nota}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Poppinss',
              ),
            ),
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              final actionController = Get.put(ActionController());
              actionController.removeAction(actions[index!].id!);
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            )),
        title: Text(
          actions[index!].acao!,
          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
