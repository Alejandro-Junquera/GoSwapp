import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ProfesorPerfilScreen extends StatefulWidget {
  const ProfesorPerfilScreen({super.key});

  @override
  State<ProfesorPerfilScreen> createState() => _ProfesorPerfilScreenState();
}

class _ProfesorPerfilScreenState extends State<ProfesorPerfilScreen> {
  List<PerfilP> estudiantesProf = [];
  List<ProfesorData> profesor = [];
  PerfilP? originalPerfil;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  obtenerEstudiantes() async {
    final teacherService = Provider.of<TeacherService>(context, listen: false);
    await teacherService.estudiantesConTareasYBoscoins();
    await teacherService.recuperarPerfil();
    setState(() {
      estudiantesProf = teacherService.estudiantesProf;
      profesor = teacherService.profesor;
      originalPerfil = PerfilP.fromJson(profesor[0].toJson());
      firstNameController.text = profesor[0].firstname ?? '';
      lastNameController.text = profesor[0].surname ?? '';
      emailController.text = profesor[0].email ?? '';
      mobileController.text = profesor[0].mobile ?? '';
      addressController.text = profesor[0].address ?? '';
    });
  }

  actualizarPerfil() async {
    // Verificar si hubo cambios
    if (originalPerfil!.firstname != firstNameController.text ||
        originalPerfil!.surname != lastNameController.text ||
        originalPerfil!.email != emailController.text ||
        originalPerfil!.mobile != mobileController.text ||
        originalPerfil!.address != addressController.text) {
      final teacherService =
          Provider.of<TeacherService>(context, listen: false);
      final resp = await teacherService.actualizarProfesor(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        mobileController.text,
        addressController.text,
      );
      return resp;
    }
    return -1;
  }

  obtenerProfesor() async {
    final teacherService = Provider.of<TeacherService>(context, listen: false);
    await teacherService.recuperarPerfil();
    setState(() {
      profesor = teacherService.profesor;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerProfesor();
    obtenerEstudiantes();
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

  double positiontop = 0;
  Icon icono = const Icon(Icons.keyboard_double_arrow_down);
  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);
    if (teacherService.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          !teacherService.editProfile
              ? IconButton(
                  onPressed: () {
                    teacherService.isEditable();
                    print(teacherService.editProfile);
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () async {
                    if (await actualizarPerfil() == 1) {
                      QuickAlert.show(
                          context: context,
                          barrierDismissible: false,
                          type: QuickAlertType.success,
                          title: 'Completado',
                          confirmBtnColor: Colors.blueGrey,
                          text: 'Profesor editado correctamente',
                          showCancelBtn: false);
                    } else if (await actualizarPerfil() == 0) {
                      QuickAlert.show(
                          context: context,
                          barrierDismissible: false,
                          type: QuickAlertType.warning,
                          title: 'Cuidado',
                          confirmBtnColor: Colors.blueGrey,
                          text: 'Email duplicado',
                          showCancelBtn: false);
                    } else {}
                    teacherService.isEditable();
                  },
                  icon: Icon(Icons.done))
        ],
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Stack(children: [
        //LISTADO DE ALUMNOS DEL CURSO DEL PROFESOR
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 115, left: 15),
                  child: Text(
                    'Lista de Alumnos',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: ListView.builder(
                      itemCount: estudiantesProf.length,
                      itemBuilder: (context, index) {
                        var alumno = estudiantesProf[index];
                        return ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(alumno.firstname.toString()),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.task_rounded,
                                        color: Color.fromARGB(255, 68, 89, 99),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(alumno.completedTasks.toString()),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        './assets/images/Boscoin.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(alumno.boscoins != null
                                          ? alumno.boscoins.toString()
                                          : '0')
                                    ],
                                  )
                                ]),
                            subtitle: Text(alumno.surname.toString()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //CONTENEDOR CON LOS DATOS DEL PROFESOR
        Positioned(
          top: positiontop,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.40,
            child: CustomPaint(
              painter: _TeacherData(),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    readOnly: teacherService.editProfile
                                        ? false
                                        : true,
                                    controller: firstNameController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        disabledBorder: OutlineInputBorder(),
                                        label: Text('Nombre')),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    readOnly: teacherService.editProfile
                                        ? false
                                        : true,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: TextField(
                                    readOnly: teacherService.editProfile
                                        ? false
                                        : true,
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
                                    ..text = !profesor.isEmpty
                                        ? profesor[0].cicleName.toString()
                                        : 'Sin datos',
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      disabledBorder: OutlineInputBorder(),
                                      enabled: false,
                                      label: Text('Curso',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 68, 89, 99)))),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, left: 10),
                            child: TextField(
                              readOnly:
                                  teacherService.editProfile ? false : true,
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
                        ],
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.07,
                        child: IconButton(
                          iconSize: 70,
                          color: Colors.white,
                          icon: icono,
                          onPressed: () {
                            if (positiontop == 0) {
                              setState(() {
                                positiontop =
                                    MediaQuery.of(context).size.height * 0.29;
                                icono = const Icon(
                                  Icons.keyboard_double_arrow_up,
                                );
                              });
                            } else {
                              setState(() {
                                positiontop = 0;
                                icono = const Icon(
                                    Icons.keyboard_double_arrow_down);
                              });
                            }
                          },
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),

        //IMAGEN USUARIO
        Positioned(
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
            ),
            height: MediaQuery.of(context).size.height * 0.29,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      './assets/images/iconoProfesor.png',
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
        ),
      ]),
    );
  }
}

class _TeacherData extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    paint.color = Colors.blueGrey[200]!;
    //paint.color = Colors.blueGrey[200]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;

    final path = Path();

    path.lineTo(0, size.height * 0.70);
    path.quadraticBezierTo(1, size.height * 0.80, 25, size.height * 0.80);
    path.lineTo(size.width * 0.65, size.height * 0.80);
    path.arcToPoint(Offset(size.width * 1.001, size.height * 0.80),
        radius: Radius.circular(1), clockwise: false);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
