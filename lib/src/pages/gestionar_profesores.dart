// ignore: depend_on_referenced_packages
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class GestionarProfesoresPage extends StatefulWidget {
  const GestionarProfesoresPage({super.key});

  @override
  State<GestionarProfesoresPage> createState() =>
      _GestionarProfesoresPageState();
}

class _GestionarProfesoresPageState extends State<GestionarProfesoresPage> {
  List<ProfesorData> profesores = [];

  obtenerProfesores() async {
    final adminService = Provider.of<AdminService>(context, listen: false);
    adminService.obtenerProfesores();
    setState(() {
      profesores = adminService.profesores;
    });
  }

  Future refresh() async {
    obtenerProfesores();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerProfesores();
  }

  @override
  Widget build(BuildContext context) {
    final adminService = Provider.of<AdminService>(context);
    if (adminService.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
            itemCount: profesores.length,
            itemBuilder: ((context, index) {
              final profesor = profesores[index];
              return Slidable(
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                    '¿Eliminar tarea ${profesor.firstname}?'),
                                content: const Text('¿Estas seguro?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      final teacherService =
                                          Provider.of<TeacherService>(context,
                                              listen: false);
                                      teacherService
                                          .borrarProfesor(profesor.userId!);
                                      setState(() {
                                        profesores.removeAt(index);
                                      });
                                      QuickAlert.show(
                                          context: context,
                                          barrierDismissible: false,
                                          type: QuickAlertType.success,
                                          title: 'Completado',
                                          confirmBtnColor: Colors.blueGrey,
                                          text:
                                              'Profesor eliminado correctamente',
                                          showCancelBtn: false);
                                    },
                                    child: const Text('Si'),
                                  ),
                                ],
                              ));
                    },
                    backgroundColor: Color.fromARGB(255, 190, 51, 41),
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Color.fromARGB(255, 27, 110, 177),
                    icon: Icons.edit,
                  ),
                ]),
                child: Container(
                  height: 70,
                  color: Colors.grey[400],
                  child: ListTile(
                    title: Text('${profesor.firstname} ${profesor.surname}'),
                    subtitle: Text(profesor.cicleName.toString()),
                    trailing: const Icon(Icons.swipe_right),
                  ),
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 5,
              );
            }),
          )),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.80,
              bottom: 15,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'crearProfesor');
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
