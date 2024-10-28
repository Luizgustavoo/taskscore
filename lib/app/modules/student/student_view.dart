import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/action_model_student.dart';
import 'package:taskscore/app/modules/student/student_detail_view.dart';
import 'package:taskscore/app/widgets/custom_app_bar.dart';
import 'package:taskscore/app/widgets/custom_student_card.dart';
import 'package:taskscore/app/widgets/modals/action_modal.dart';
import 'package:taskscore/app/widgets/modals/observation_modal.dart';

class StudentView extends GetView<StudentController> {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    final isTablet = shortestSide > 600;

    final buttonSize = isTablet ? const Size(65, 65) : const Size(50, 50);

    DateTime selectedDate = DateTime.now();
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
                        heroTag:
                            'studentHeroTag_${controller.listStudents[index].idMatricula}',
                        onLongPress: () {
                          Get.to(
                              () => StudentDetailsView(
                                  controller: controller,
                                  student: controller.listStudents[index]),
                              transition: Transition.fadeIn);
                        },
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
                                                                  .removeActionStudent(
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
            SpeedDialChild(
              backgroundColor: Colors.grey,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.white,
                ),
              ),
              label: 'Observações',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CreateObservationModal(
                      studentController: controller,
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              backgroundColor: Colors.grey,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.add_task_rounded,
                  color: Colors.white,
                ),
              ),
              label: 'Frequência',
              onTap: () {
                // Variável para armazenar a data selecionada

                // Abre o modal
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Lançar Frequência',
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                          ),
                          Divider(
                            thickness: 2,
                            endIndent: 20,
                            color: Colors.blue.shade400,
                          ),
                          TextField(
                            readOnly: true, // O campo é somente leitura
                            decoration: const InputDecoration(
                              labelText: 'Data Selecionada',
                              hintText: 'Selecione uma data',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                                text: DateFormat('dd/MM/yyyy').format(
                                    selectedDate)), // Formatação da data
                            onTap: () async {
                              // Ao clicar, abre o DatePicker
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: selectedDate
                                    .subtract(const Duration(days: 30)),
                                lastDate: selectedDate,
                              );

                              if (newDate != null) {
                                selectedDate =
                                    newDate; // Atualiza a data selecionada
                                // Atualiza o TextField com a nova data
                                (context as Element)
                                    .markNeedsBuild(); // Atualiza a UI
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var mensagem = await controller
                                        .existFrequencyForStudents(
                                            DateFormat('yyyy-MM-dd')
                                                .format(selectedDate));

                                    if (mensagem['code'] != null &&
                                        mensagem['code'] == 1) {
                                      Get.defaultDialog(
                                        title: "Confirmação",
                                        titleStyle: const TextStyle(
                                            fontFamily: 'Poppinss',
                                            color: Colors.black87),
                                        middleText:
                                            "Já existe lançamento nessa data para seu usuário. Se continuar será substituido?",
                                        middleTextStyle: const TextStyle(
                                            fontFamily: 'Poppins'),
                                        confirm: ElevatedButton(
                                          onPressed: () async {
                                            var retorno = await controller
                                                .sendFrequencyForStudents(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(selectedDate));
                                            Get.back();
                                            Get.back();
                                            if (retorno['code'] != null &&
                                                retorno['code'] == 0) {
                                              Get.snackbar(
                                                  'Sucesso', retorno['objeto'],
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white);
                                            } else {
                                              Get.snackbar(
                                                  'Falha', retorno['objeto'],
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          },
                                          child: const Text(
                                            "Sim",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                        ),
                                        cancel: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            "Não",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    } else {
                                      var retorno = await controller
                                          .sendFrequencyForStudents(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate));
                                      Get.back();
                                      if (retorno['code'] != null &&
                                          retorno['code'] == 0) {
                                        Get.snackbar(
                                            'Sucesso', retorno['objeto'],
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white);
                                      } else {
                                        Get.snackbar('Falha', retorno['objeto'],
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      }
                                    }

                                    selectedDate = DateTime.now();
                                  },
                                  child: const Text(
                                    'Salvar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
