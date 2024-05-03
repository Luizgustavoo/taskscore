import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/action_model_student.dart';
import 'package:taskscore/app/widgets/custom_app_bar.dart';
import 'package:taskscore/app/widgets/custom_student_card.dart';
import 'package:taskscore/app/widgets/modals/action_modal.dart';

class StudentView extends GetView<StudentController> {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    final isTablet = shortestSide > 600;

    final buttonSize = isTablet ? const Size(65, 65) : const Size(50, 50);
    return Scaffold(
      appBar: CustomAppBar(
        showPadding: false,
        title: 'Alunos',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(15),
            topEnd: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(5),
                  itemCount: controller.listStudents.length,
                  itemBuilder: (context, index) {
                    controller.allIndexs.add(index);
                    return Obx(() {
                      var fotoPessoa =
                          controller.listStudents[index].fotoPessoa.toString();
                      return CustomStudentCard(
                        title: controller.listStudents[index].nomePessoa!,
                        avatar: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            controller.listStudents[index].actions!.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          RxList<ActionModelStudent> actions =
                                              <ActionModelStudent>[].obs;
                                          actions.value = controller
                                              .listStudents[index].actions!;
                                          return Obx(() => ListView.builder(
                                              padding: const EdgeInsets.all(12),
                                              itemCount: actions.length,
                                              itemBuilder: (context, i) {
                                                return Card(
                                                  child: ListTile(
                                                    leading: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          width: 35,
                                                          height: 35,
                                                          child: Image.asset(
                                                              'assets/images/coin.png'),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          '${actions[i].nota}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Poppinss',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: IconButton(
                                                        onPressed: () async {
                                                          showConfirmationDialog(
                                                            context,
                                                            actions[i].id!,
                                                            () async {
                                                              final actionController =
                                                                  Get.put(
                                                                      ActionController());
                                                              await actionController
                                                                  .removeAction(
                                                                      actions[i]
                                                                          .id!);

                                                              actions
                                                                  .removeAt(i);
                                                              controller
                                                                  .getStudents();

                                                              if (actions
                                                                  .isEmpty) {
                                                                Get.back();
                                                              }
                                                            },
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          color: Colors.red,
                                                        )),
                                                    title: Text(
                                                      actions[i].acao!,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                );
                                              }));
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.info_outline,
                                      size: 28,
                                    ),
                                  )
                                : const SizedBox(
                                    // width: 28,
                                    // height: 28,
                                    ),
                            const SizedBox(width: 5),
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: controller
                                      .listStudents[index].fotoPessoa
                                      .toString()
                                      .isEmpty
                                  ? const AssetImage(
                                      'assets/images/default_avatar.jpg')
                                  : NetworkImage('$foto/$fotoPessoa')
                                      as ImageProvider,
                            ),
                          ],
                        ),
                        score: controller.listStudents[index].cash != null
                            ? int.parse(
                                controller.listStudents[index].cash.toString())
                            : 0,
                        isSelected: controller.selectedIndexes.contains(index),
                        onTap: () {
                          controller.toggleStudentSelection(
                              index,
                              int.parse(
                                  controller.listStudents[index].idMatricula!));
                        },
                      );
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => SpeedDial(
          buttonSize: buttonSize,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          isOpenOnStart: false,
          visible: controller.selectedIndexes.isEmpty ? false : true,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.green,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/images/coin.png'),
              ),
              label: 'Positivo',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    final actionController = Get.put(ActionController());
                    actionController.getActions();
                    return ActionModal(
                      actionList: actionController.positiveActions,
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              backgroundColor: Colors.red,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/images/coin.png'),
              ),
              label: 'Negativo',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    final actionController = Get.put(ActionController());
                    actionController.getActions();
                    return ActionModal(
                      actionList: actionController.negativeActions,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(
      BuildContext context, int actionId, VoidCallback onConfirm) {
    Get.defaultDialog(
      title: "Confirmação",
      titleStyle:
          const TextStyle(fontFamily: 'Poppinss', color: Colors.black87),
      middleText: "Tem certeza de que deseja remover esta ação?",
      middleTextStyle: const TextStyle(fontFamily: 'Poppins'),
      confirm: ElevatedButton(
        onPressed: () {
          onConfirm();

          Get.back();
        },
        child: const Text(
          "Sim",
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Não",
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
    );
  }
}
