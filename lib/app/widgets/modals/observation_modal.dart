import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';

class CreateObservationModal extends StatelessWidget {
  const CreateObservationModal({super.key, required this.studentController});

  final StudentController studentController;

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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Observações',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              Divider(
                thickness: 2,
                endIndent: 20,
                color: Colors.blue.shade400,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: studentController.observation,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Observações',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
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
                        var mensagem = await studentController
                            .sendObservationForStudents();
                        Get.back();
                        if (mensagem['code'] != null && mensagem['code'] == 0) {
                          Get.snackbar('Sucesso', mensagem['objeto'],
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                          studentController.getStudents();
                        } else {
                          Get.snackbar('Falha', mensagem['objeto'],
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
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
          )
        ],
      ),
    );
  }
}
