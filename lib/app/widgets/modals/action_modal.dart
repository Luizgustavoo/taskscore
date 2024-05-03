import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/widgets/custom_action_card.dart';

class ActionModal extends StatefulWidget {
  final List<ActionModel>? actionList;
  const ActionModal({super.key, this.actionList});

  @override
  State<ActionModal> createState() => _ActionModalState();
}

class _ActionModalState extends State<ActionModal> {
  final actionController = Get.put(ActionController());
  RxInt quantity = 0.obs;
  @override
  Widget build(BuildContext context) {
    actionController.clearIndex();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: widget.actionList!.length,
                itemBuilder: (context, index) {
                  return Obx(() => CustomActionCard(
                        actionList: widget.actionList!,
                        index: index,
                        title: widget.actionList![index].acao!,
                        score: int.parse(widget.actionList![index].nota!),
                      ));
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool? confirmed = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmação',
                            style: TextStyle(
                              fontFamily: 'Poppinss',
                            )),
                        content: const Text('Você tem certeza que quer salvar?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              'Não',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Sim',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed == true) {
                    var mensagem =
                        await actionController.sendActionForStudents();
                    Get.back();
                    if (mensagem['code'] != null && mensagem['code'] == 0) {
                      Get.snackbar('Sucesso', mensagem['objeto'],
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                      final studentController = Get.put(StudentController());
                      studentController.selectedIndexes.clear();
                      studentController.selectedStudents.clear();
                      studentController.getStudents();
                    } else {
                      Get.snackbar('Falha', mensagem['objeto'],
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  }
                },
                child: const Text(
                  'SALVAR',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
