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
  Map<String, dynamic>? originalPerfil;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  obtenerPerfil() async {
    final userService = Provider.of<UserService>(context, listen: false);
    perfil = await userService.obtenerPerfilUser();

    setState(() {
      originalPerfil = perfil;
      firstNameController.text = perfil!['Usuario']['firstname'] ?? '';
      lastNameController.text = perfil!['Usuario']['surname'] ?? '';
      emailController.text = perfil!['Usuario']['email'] ?? '';
      mobileController.text = perfil!['Usuario']['mobile'] ?? '';
      addressController.text = perfil!['Usuario']['address'] ?? '';
    });
  }

  void actualizarPerfil() {
    // Verificar si hubo cambios
    if (originalPerfil!['Usuario']['firstname'] != firstNameController.text ||
        originalPerfil!['Usuario']['surname'] != lastNameController.text ||
        originalPerfil!['Usuario']['email'] != emailController.text ||
        originalPerfil!['Usuario']['mobile'] != mobileController.text ||
        originalPerfil!['Usuario']['address'] != addressController.text) {
      final userService = Provider.of<UserService>(context, listen: false);
      userService.actualizarUsuario(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        mobileController.text,
        addressController.text,
      );
    }
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
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    super.dispose();
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
        actions: [
          !userService.editProfile
              ? IconButton(
                  onPressed: () {
                    userService.isEditable();
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () {
                    actualizarPerfil();
                    userService.isEditable();
                  },
                  icon: Icon(Icons.done))
        ],
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: userService.editProfile ? false : true,
                  controller: firstNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      label: Text('Nombre',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey))),
                ),
              ),
              Expanded(
                child: TextField(
                  readOnly: userService.editProfile ? false : true,
                  controller: lastNameController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      label: Text('Apellidos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: userService.editProfile ? false : true,
            controller: emailController,
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                label: Text('Email',
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
              readOnly: userService.editProfile ? false : true,
              controller: mobileController,
              maxLines: 1,
              decoration: const InputDecoration(
                  disabledBorder: OutlineInputBorder(),
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
            readOnly: userService.editProfile ? false : true,
            controller: addressController,
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
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
