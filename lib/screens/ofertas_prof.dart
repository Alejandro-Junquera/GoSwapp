import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
import 'package:flutter_aplicacion_ganadora/src/pages/pages.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/bottomnavigationbar_personalizado.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class OfertasProfScreen extends StatelessWidget {
  const OfertasProfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Menú Profesor'),
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
      bottomNavigationBar: const BottomNavigationBarPersonalizado(),
    );
  }
}

class _Ofertas extends StatelessWidget {
  const _Ofertas({super.key});

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<ProfProvider>(context);
    final currentIndex = profProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return const OfertasGlobalesPage();
      case 1:
        return OfertasPublicadasPage();
      default:
        return const OfertasGlobalesPage();
    }
  }
}
