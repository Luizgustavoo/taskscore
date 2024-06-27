import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';
import 'package:taskscore/app/data/models/category_action.dart';

class CreateActionModal extends StatelessWidget {
  const CreateActionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Cadastro de Ações',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome da Ação',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.warning_rounded),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.monetization_on),
                ),
              ),
              const SizedBox(height: 15),
              Obx(() {
                final actionController = ActionController();
                return DropdownButtonFormField<int>(
                  isDense: true,
                  menuMaxHeight: Get.size.height / 2,
                  value: actionController.categorySelected!.value > 0
                      ? actionController.categorySelected!.value
                      : null,
                  onChanged: (value) {
                    if (value != null) {
                      actionController.categorySelected!.value = value;
                    }
                  },
                  items: [
                    const DropdownMenuItem<int>(
                      value: null,
                      child: Text('Selecione uma categoria'),
                    ),
                    ...actionController.listCategoryActions
                        .map<DropdownMenuItem<int>>(
                            (CategoryAction categoryAction) {
                      return DropdownMenuItem<int>(
                        value: categoryAction.id,
                        child: Text(categoryAction.descricao!),
                      );
                    }),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Categoria',
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 15),
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
                        final ActionController actionController =
                            ActionController();
                        actionController.createAction();
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
          ))
        ],
      ),
    );
  }
}
