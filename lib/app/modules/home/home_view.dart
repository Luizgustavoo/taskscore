import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/class_controller.dart';
import 'package:taskscore/app/data/controllers/home_controller.dart';
import 'package:taskscore/app/utils/auth_storage.dart';
import 'package:taskscore/app/widgets/custom_app_bar.dart';
import 'package:taskscore/app/widgets/custom_drawer.dart';
import 'package:taskscore/app/widgets/custom_graphic.dart';
import 'package:taskscore/app/widgets/custom_home_card.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final classController = Get.find<ClassController>();

  @override
  Widget build(BuildContext context) {
    final List<String>? userName = AuthStorage.getUserName()?.split(' ');
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        showPadding: true,
        title: '',
        userName: userName![0],
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              child: const Text(
                'Selecione o Projeto e o Período',
                style: TextStyle(fontSize: 18, fontFamily: 'Poppinss'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomHomeCard(
                  onTap: () {
                    classController.getClasses('1', 'matutino');
                    Get.toNamed('/class');
                  },
                  title: 'Matutino',
                  imageUrl: 'assets/images/crescer-1.png',
                ),
                CustomHomeCard(
                  onTap: () {
                    classController.getClasses('1', 'vespertino');
                    Get.toNamed('/class');
                  },
                  title: 'Vespertino',
                  imageUrl: 'assets/images/crescer-1.png',
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomHomeCard(
                  onTap: () {
                    classController.getClasses('2', 'matutino');
                    Get.toNamed('/class');
                  },
                  title: 'Matutino',
                  imageUrl: 'assets/images/crescer-2.png',
                ),
                CustomHomeCard(
                  onTap: () {
                    classController.getClasses('2', 'vespertino');
                    Get.toNamed('/class');
                  },
                  title: 'Vespertino',
                  imageUrl: 'assets/images/crescer-2.png',
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              endIndent: 20,
              indent: 20,
              height: 3,
              thickness: 2,
              color: Color(0xfffc9805),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              child: Text(
                'Ranking Mensal ${controller.actualMonth().toString()} 👑',
                style: const TextStyle(fontSize: 18, fontFamily: 'Poppinss'),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.listRankings.length,
                  itemBuilder: (context, index) {
                    var fotoPessoa =
                        controller.listRankings[index].fotoPessoa.toString();
                    return RowGrafh(
                      avatar: CircleAvatar(
                        radius: 22,
                        backgroundImage: controller
                                .listRankings[index].fotoPessoa
                                .toString()
                                .isEmpty
                            ? const AssetImage(
                                'assets/images/default_avatar.jpg')
                            : NetworkImage('$foto/$fotoPessoa')
                                as ImageProvider,
                      ),
                      largura: double.parse(controller
                                  .listRankings[index].porcentagemPontos) <
                              0
                          ? double.parse(controller
                                  .listRankings[index].porcentagemPontos) *
                              -1
                          : double.parse(
                              controller.listRankings[index].porcentagemPontos),
                      nomeAluno: controller.listRankings[index].nomePessoa!,
                      cor: controller.randomColor(),
                      score: double.parse(
                          controller.listRankings[index].totalNotas!),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
