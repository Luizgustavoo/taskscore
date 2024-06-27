import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/widgets/custom_app_bar.dart';
import 'package:taskscore/app/widgets/custom_list_action_card.dart';
import 'package:taskscore/app/widgets/modals/create_action_modal.dart';

class ActionView extends GetView<ActionController> {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showPadding: false,
        title: 'Listagem de Ações',
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
              // if (controller.aulasPorDia.isEmpty) {
              //   return Expanded(
              //     child: ListView.builder(
              //       padding: const EdgeInsets.all(5),
              //       itemCount: 10,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Container();
              //       },
              //     ),
              //   );
              // } else {
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: controller.listActions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final action = controller.listActions[index];
                    return CustomListActionCard(action: action);
                  },
                ),
              );
              // }
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: const Color(0xFF1C6399),
        onPressed: () {
          controller.getCategoryActions();
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const CreateActionModal();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
