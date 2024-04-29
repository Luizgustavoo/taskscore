import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.userName, this.showPadding, this.title});
  final String? userName;
  final bool? showPadding;
  final String? title;

  @override
  Size get preferredSize {
    double factor = 0.15;
    if (showPadding == false) {
      factor = 0.10;
    }
    return Size.fromHeight(Get.height * factor);
  }

  final RxString greeting = ''.obs;

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    greeting.value = getGreeting(currentTime);

    ever(greeting, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.forceAppUpdate();
      });
    });
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        if (Get.currentRoute == '/student') ...[
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 8),
            child: IconButton(
              onPressed: () {
                final studentController = Get.put(StudentController());

                for (var element in studentController.listStudents) {
                  for (var index in studentController.allIndexs) {
                    studentController.toggleStudentSelection2(
                        index, int.parse(element.idMatricula!));
                  }
                }

                studentController.isSelection = !studentController.isSelection;
              },
              icon: Obx(() {
                final studentController = Get.put(StudentController());

                if (studentController.selectedIndexes.isEmpty) {
                  return const Icon(Icons.format_list_bulleted_rounded);
                } else {
                  return const Icon(Icons.checklist_rounded);
                }
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.filter_alt),
              onSelected: (String value) {
                // Esta função é chamada quando uma opção é selecionada
                final studentController = Get.put(StudentController());
                if (value == 'filter_name') {
                  studentController.sort('name');
                } else if (value == 'filter_score') {
                  studentController.sort('score');
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                    value: 'filter_name',
                    child: Text('Filtrar por nome'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'filter_score',
                    child: Text('Filtrar por score'),
                  ),
                ];
              },
            ),
          ),
        ]
      ],
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: showPadding == false
                ? const EdgeInsets.only(right: 20, top: 25)
                : const EdgeInsets.only(left: 20, right: 20, top: 22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (showPadding == false)
                          IconButton(
                            onPressed: () {
                              if (Get.currentRoute == '/student') {
                                final studentController =
                                    Get.put(StudentController());
                                studentController.selectedStudents.clear();
                                studentController.allIndexs.clear();
                                studentController.selectedIndexes.clear();
                                Get.offNamed('/class');
                              } else {
                                Get.offAllNamed('/');
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                if (title!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontFamily: 'Poppinss',
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (showPadding!)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Olá, $userName ',
                              style: const TextStyle(
                                  fontFamily: 'Poppinss',
                                  fontSize: 22,
                                  color: Colors.white)),
                          const HandWaveAnimation(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('$greeting, seja bem-vindo!',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String getGreeting(DateTime currentTime) {
    String greeting = '';

    if (currentTime.hour < 12) {
      greeting = 'Bom dia';
    } else if (currentTime.hour < 18) {
      greeting = 'Boa tarde';
    } else {
      greeting = 'Boa noite';
    }

    return greeting;
  }
}

class HandWaveAnimation extends StatefulWidget {
  const HandWaveAnimation({super.key});

  @override
  State<HandWaveAnimation> createState() => _HandWaveAnimationState();
}

class _HandWaveAnimationState extends State<HandWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.08).animate(_controller),
      child: const Text(
        '👋',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
