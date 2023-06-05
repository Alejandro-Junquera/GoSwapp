import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';

class AlumnoPerfilScreen extends StatefulWidget {
  const AlumnoPerfilScreen({super.key});

  @override
  State<AlumnoPerfilScreen> createState() => _AlumnoPerfilScreenState();
}

class _AlumnoPerfilScreenState extends State<AlumnoPerfilScreen> {
  List<AlumnoPerfilData>? perfil;
  AlumnoPerfilData? originalPerfil;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  obtenerPerfil() async {
    final alumnoService = Provider.of<AlumnoService>(context, listen: false);
    await alumnoService.obtenerPerfilAlumno();
    setState(() {
      perfil = alumnoService.perfil;
      originalPerfil = AlumnoPerfilData.fromJson(perfil![0].toJson());
      firstNameController.text = perfil![0].firstname ?? '';
      lastNameController.text = perfil![0].surname ?? '';
      emailController.text = perfil![0].email ?? '';
      mobileController.text = perfil![0].mobile ?? '';
      addressController.text = perfil![0].address ?? '';
    });
  }

  void actualizarPerfil() {
    // Verificar si hubo cambios
    if (originalPerfil!.firstname != firstNameController.text ||
        originalPerfil!.surname != lastNameController.text ||
        originalPerfil!.email != emailController.text ||
        originalPerfil!.mobile != mobileController.text ||
        originalPerfil!.address != addressController.text) {
      final alumnoService = Provider.of<AlumnoService>(context, listen: false);
      alumnoService.actualizarAlumno(
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
    super.initState();
    obtenerPerfil();
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
    final alumnoService = Provider.of<AlumnoService>(context);
    if (alumnoService.isLoading)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        title: const Text("Perfil"),
        actions: [
          !alumnoService.editProfile
              ? IconButton(
                  onPressed: () {
                    alumnoService.isEditable();
                    print(alumnoService.editProfile);
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () {
                    actualizarPerfil();
                    alumnoService.isEditable();
                    print(alumnoService.editProfile);
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
                    './assets/images/iconoAlumno.png',
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        './assets/images/Boscoin.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        perfil![0].boscoins != null
                            ? perfil![0].boscoins.toString()
                            : '0',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
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
                  readOnly: alumnoService.editProfile ? false : true,
                  controller: firstNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      label: Text('Nombre')),
                ),
              ),
              Expanded(
                child: TextField(
                  readOnly: alumnoService.editProfile ? false : true,
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: alumnoService.editProfile ? false : true,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: TextField(
                  readOnly: alumnoService.editProfile ? false : true,
                  controller: mobileController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.blueGrey,
                      ))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: TextField(
                readOnly: true,
                controller: TextEditingController()
                  ..text = perfil![0].cicleName != null
                      ? perfil![0].cicleName.toString()
                      : '',
                maxLines: 1,
                decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(),
                    enabled: false,
                    label: Text('Curso',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueGrey))),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: alumnoService.editProfile ? false : true,
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
