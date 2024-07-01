import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/widgets/show_confirmation_dialog.dart';

class CustomListActionCard extends StatelessWidget {
  const CustomListActionCard({
    super.key,
    required this.action,
  });

  final ActionModel action;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          showConfirmationDialog(
            titulo: 'Desativar',
            subtitulo: 'Deseja realmente desativar essa ação? (${action.acao})',
            onCancel: () {
              Get.back();
            },
            onConfirm: () {
              print('aqui');
            },
          );
        }
        return false;
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red.shade500,
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete_outline, color: Colors.white, size: 25)
                ],
              ),
            ),
          ),
        ),
      ),
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(5),
        child: ListTile(
          title: Text(
            action.acao!,
            style: const TextStyle(fontFamily: 'Poppinss'),
          ),
          subtitle: Text(
            'VALOR:  ${action.nota}',
            style: const TextStyle(
                fontFamily: 'Poppins', color: Color(0xFF1C6399)),
          ),
        ),
      ),
    );
  }
}
