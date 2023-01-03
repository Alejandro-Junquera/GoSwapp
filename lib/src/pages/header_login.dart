import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/src/widgets/headers.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginHeader(),
    );
  }
}
