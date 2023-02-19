// ignore_for_file: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
import 'package:flutter_aplicacion_ganadora/src/pages/pages.dart';

import '../services/services.dart';
import '../src/widgets/bottomnavigationbar_personalizado_admin.dart';

class OfertasAdminScreen extends StatelessWidget {
  const OfertasAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Menú Admin'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final logOutService =
                Provider.of<AuthService>(context, listen: false);
            await logOutService.logout();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const _Ofertas(),
      bottomNavigationBar: const BottomNavigationBarPersonalizadoAdmin(),
    );
  }
}

class _Ofertas extends StatelessWidget {
  const _Ofertas({super.key});

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<AdminProvider>(context);
    final currentIndex = profProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return const OfertasAdminPage();
      case 1:
        return const GestionarProfesoresPage();
      default:
        return const OfertasAdminPage();
    }
  }
}
