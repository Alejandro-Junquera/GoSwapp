import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';

class ClientePerfilScreen extends StatefulWidget {
  const ClientePerfilScreen({super.key});

  @override
  State<ClientePerfilScreen> createState() => _ClientePerfilScreenState();
}

class _ClientePerfilScreenState extends State<ClientePerfilScreen> {
  Map<String, dynamic>? perfil;
  obtenerPerfil() async {
    final userService = Provider.of<UserService>(context, listen: false);
    perfil = await userService.obtenerPerfilUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(milliseconds: 50),
      () {
        obtenerPerfil();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        title: const Text("Perfil"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    './assets/images/iconoCliente.png',
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: true,
            controller: TextEditingController()
              ..text = perfil == null
                  ? ''
                  : perfil!['Usuario']['firstname'].toString() +
                      ' ' +
                      perfil!['Usuario']['surname'].toString(),
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                enabled: false,
                label: Text('Nombre Completo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: true,
            controller: TextEditingController()
              ..text =
                  perfil == null ? '' : perfil!['Usuario']['email'].toString(),
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                enabled: false,
                label: Text('Email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey)),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.blueGrey,
                )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              readOnly: true,
              controller: TextEditingController()
                ..text = perfil == null
                    ? ''
                    : perfil!['Usuario']['mobile'].toString(),
              maxLines: 1,
              decoration: const InputDecoration(
                  disabledBorder: OutlineInputBorder(),
                  label: Text('Telefono',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueGrey)),
                  enabled: false,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueGrey,
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: true,
            controller: TextEditingController()
              ..text = perfil == null
                  ? ''
                  : perfil!['Usuario']['address'].toString(),
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                enabled: false,
                label: Text('Direccion',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey)),
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                )),
          ),
        )
      ]),
    );
  }
}
