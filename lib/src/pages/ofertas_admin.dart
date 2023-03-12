// ignore: depend_on_referenced_packages
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';
import '../../providers/providers.dart';

class OfertasAdminPage extends StatefulWidget {
  const OfertasAdminPage({super.key});

  @override
  State<OfertasAdminPage> createState() => _OfertasAdminPageState();
}

class _OfertasAdminPageState extends State<OfertasAdminPage> {
  List<TareasDataUser> tareasSinCiclo = [];
  List<CicloData> ciclos = [];
  obtenerTareasSinCiclo() async {
    final adminService = Provider.of<AdminService>(context, listen: false);
    adminService.obtenerTareasSinCiclo();
    setState(() {
      tareasSinCiclo = adminService.tareasPorAsignar;
    });
  }

  getCiclos() {
    Future.delayed(
      Duration(milliseconds: 500),
      () async {
        final ciclosService =
            Provider.of<CiclosService>(context, listen: false);
        await ciclosService.getCiclos();
        setState(() {
          ciclos = ciclosService.ciclos;
        });
      },
    );
  }

  Future refresh() async {
    obtenerTareasSinCiclo();
    getCiclos();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTareasSinCiclo();
    getCiclos();
  }

  @override
  Widget build(BuildContext context) {
    final adminForm = Provider.of<AdminFormProvider>(context);
    final adminService = Provider.of<AdminService>(context);
    if (adminService.isLoading)
      return Center(child: CircularProgressIndicator());
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: tareasSinCiclo.length,
              itemBuilder: ((context, index) {
                final tarea = tareasSinCiclo[index];
                return Slidable(
                  startActionPane:
                      ActionPane(motion: const DrawerMotion(), children: [
                    SlidableAction(
                      onPressed: (BuildContext context) async {
                        if (adminForm.cicloId == 0) {
                          QuickAlert.show(
                              context: context,
                              barrierDismissible: false,
                              type: QuickAlertType.info,
                              title: 'Informacion',
                              confirmBtnColor: Colors.blueGrey,
                              text: 'Selecciona un ciclo',
                              confirmBtnText: 'Vale');
                        } else {
                          final adminService =
                              Provider.of<AdminService>(context, listen: false);
                          adminService.asignarCicloaTarea(
                              tarea.id!, adminForm.cicloId);
                          tareasSinCiclo.removeAt(index);
                          QuickAlert.show(
                              context: context,
                              barrierDismissible: false,
                              type: QuickAlertType.success,
                              title: 'Completado',
                              confirmBtnColor: Colors.blueGrey,
                              text: tarea.title.toString() +
                                  ' publicada correctamente',
                              showCancelBtn: false);
                          adminForm.cicloId = 0;
                        }
                      },
                      backgroundColor: Color.fromARGB(255, 15, 161, 20),
                      icon: Icons.check,
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title:
                                      Text('¿Eliminar tarea ${tarea.title}?'),
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
                                        final teacherService =
                                            Provider.of<TeacherService>(context,
                                                listen: false);
                                        Navigator.pop(context);
                                        teacherService
                                            .eliminarUnaTarea(tarea.id!);
                                        setState(() {
                                          tareasSinCiclo.removeAt(index);
                                        });
                                        QuickAlert.show(
                                            context: context,
                                            barrierDismissible: false,
                                            type: QuickAlertType.success,
                                            title: 'Completado',
                                            confirmBtnColor: Colors.blueGrey,
                                            text: tarea.title.toString() +
                                                ' eliminada correctamente',
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
                  ]),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        border: Border.all(color: Colors.blueGrey, width: 2),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    height: 140,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${tarea.title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.blueGrey[200],
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                tarea.title.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Text(
                                                  tarea.createdAt.toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          content: Text(
                                            tarea.description.toString(),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .blueGrey[600],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        60))),
                                                    height: 60,
                                                    width: 60,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 15),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel_outlined,
                                                          size: 30,
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.article,
                                    color: Colors.grey[600],
                                    size: 35,
                                    shadows: [
                                      Shadow(
                                          color: Colors.grey[300]!,
                                          offset: Offset.fromDirection(20))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.book),
                              dropdownColor: Colors.grey[300],
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey[800]!)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey))),
                              hint: const Text('Seleciona un ciclo'),
                              items: ciclos.map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name.toString()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                adminForm.cicloId = value!;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
