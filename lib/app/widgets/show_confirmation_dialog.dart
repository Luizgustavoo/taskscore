import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showConfirmationDialog(
    {required String titulo,
    required String subtitulo,
    required VoidCallback onConfirm,
    required VoidCallback onCancel}) {
  Get.defaultDialog(
    titlePadding: const EdgeInsets.all(16),
    contentPadding: const EdgeInsets.all(16),
    title: titulo,
    titleStyle: const TextStyle(
      fontFamily: 'Poppinss',
      fontSize: 22,
    ),
    content: Text(
      textAlign: TextAlign.center,
      subtitulo,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onCancel,
        child: const Text(
          "Cancelar",
          style: TextStyle(color: Color(0xFF014acb), fontFamily: 'Poppins'),
        ),
      ),
      ElevatedButton(
        onPressed: onConfirm,
        child: const Text(
          "Confirmar",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
      ),
    ],
  );
}
