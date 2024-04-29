// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/home_controller.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? userName = AuthStorage.getUserName();
    final fotoPessoa = AuthStorage.getUserPhoto().toString();
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1C6399), Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AuthStorage.getUserPhoto().toString() !=
                            null
                        ? const AssetImage('assets/images/default_avatar.jpg')
                        : NetworkImage('$foto/$fotoPessoa') as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppinss'),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.add_box_rounded,
                color: Colors.black87,
              ),
              title: const Text(
                'Cadastro de Ações',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Sair',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
              onTap: () {
                final homeController = Get.put(HomeController());
                homeController.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
