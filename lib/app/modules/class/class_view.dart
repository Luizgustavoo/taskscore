import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/class_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/widgets/custom_app_bar.dart';
import 'package:taskscore/app/widgets/custom_class_card.dart';
import 'package:taskscore/app/widgets/shimmer/shimmer_class_card.dart';

class ClassView extends GetView<ClassController> {
  ClassView({super.key});

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showPadding: false,
        title: 'Turmas',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (controller.aulasPorDia.isEmpty) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const ShimmerClassCard();
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: controller.aulasPorDia.length,
                    itemBuilder: (BuildContext context, int index) {
                      String dia = controller.aulasPorDia.keys.elementAt(index);
                      List<Map<String, String>>? aulas =
                          controller.aulasPorDia[dia];
                      return CustomClassCard(
                        dia: dia,
                        aulas: aulas,
                        controller: controller,
                        studentController: studentController,
                      );
                    },
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
