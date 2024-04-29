import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
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
                        avatar: CircleAvatar(
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
      floatingActionButton: Obx(() => SpeedDial(
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
          )),
    );
  }
}
