import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

List<Widget> estado = <Widget>[
  const Text('Todas'),
  const Text('Solicitadas'),
  const Text('Asignadas'),
  const Text('Finalizadas'),
];

class AlumnoScreen extends StatefulWidget {
  const AlumnoScreen({super.key});

  @override
  State<AlumnoScreen> createState() => _AlumnoScreenState();
}

class _AlumnoScreenState extends State<AlumnoScreen> {
  List<bool> estadoSelecionado = <bool>[true, false, false, false];
  List<EstudianteInfo> info = [];
  List<TareasAlumnoCiclo> tareas = [];
  List<TareasAsignadasAlumno> tareasAsignadas = [];
  List<TareasAlumnoCiclo> aux = [];
  String boscoins = '';

  Color? colorBorde;
  obtenerTareasAlumno() async {
    final alumnoService = Provider.of<AlumnoService>(context, listen: false);
    boscoins = await alumnoService.getTareas();
    setState(() {
      info = alumnoService.info;
      tareas = alumnoService.tareas;
      tareasAsignadas = alumnoService.tareasAsignadas;
      aux = tareas;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTareasAlumno();
  }

  @override
  Widget build(BuildContext context) {
    final alumnoService = Provider.of<AlumnoService>(context);
    if (alumnoService.isLoading)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(
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
          backgroundColor: Colors.blueGrey[800],
          title: Center(
              child: Text(
            'Ofertas Alumno',
          )),
          actions: [
            Center(child: Text(boscoins)),
            SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/images/Boscoin.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'perfilAlumno');
                },
                icon: Icon(Icons.manage_accounts))
          ]),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < estado.length; i++) {
                  estadoSelecionado[i] = i == index;
                  switch (index) {
                    case 1:
                      var aux2 = tareasAsignadas.where((element) =>
                          element.completedAt == null &&
                          element.assignedAt == null);
                      List<TareasAlumnoCiclo> solicitadas = [];
                      for (var i in aux) {
                        for (var x in aux2) {
                          if (i.taskId == x.taskId &&
                              i.completionDate == null) {
                            solicitadas.add(i);
                          }
                        }
                      }
                      tareas = solicitadas;

                      break;
                    case 2:
                      var aux2 = tareasAsignadas.where((element) =>
                          element.completedAt == null &&
                          element.assignedAt != null);
                      List<TareasAlumnoCiclo> solicitadas = [];
                      for (var i in aux) {
                        for (var x in aux2) {
                          if (i.taskId == x.taskId &&
                              i.completionDate == null) {
                            solicitadas.add(i);
                          }
                        }
                      }
                      tareas = solicitadas;
                      break;
                    case 3:
                      tareas = aux;
                      tareas = tareas
                          .where((element) => element.completionDate != null)
                          .toList();

                      break;
                    default:
                      tareas = aux;
                  }
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.blueGrey,
            selectedColor: Colors.white,
            fillColor: Colors.blueGrey[200],
            color: Colors.blueGrey[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: estadoSelecionado,
            children: estado,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tareas.length,
                itemBuilder: ((context, index) {
                  var tareaAsignada = tareasAsignadas.singleWhere(
                      (element) => element.taskId == tareas[index].taskId,
                      orElse: () {
                    return TareasAsignadasAlumno();
                  });
                  if (tareas[index].completionDate != null) {
                    colorBorde = Colors.red;
                  } else {
                    if (tareaAsignada.taskId == null) {
                      colorBorde = Colors.grey;
                    } else {
                      if (tareaAsignada.completedAt == null &&
                          tareaAsignada.assignedAt == null) {
                        colorBorde = Colors.amber;
                      } else if (tareaAsignada.completedAt == null &&
                          tareaAsignada.assignedAt != null) {
                        colorBorde = Colors.green;
                      }
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: colorBorde!, width: 1.5),
                            color: Colors.grey[350],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                                child: Text(
                                  tareas[index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropCapText(
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  tareas[index].description.toString(),
                                  dropCap: DropCap(
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30)),
                                          child: tareas[index].imagen != null
                                              ? Image.network(
                                                  'https://goswapp.allsites.es/storage/app/public/' +
                                                      tareas[index]
                                                          .imagen
                                                          .toString(),
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/no-image.jpg",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Fecha publicacion:  ' +
                                        tareas[index]
                                            .createdAt
                                            .toString()
                                            .substring(0, 11),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    tareas[index].completionDate != null
                                        ? 'Fecha finalizacion: ' +
                                            tareas[index]
                                                .completionDate
                                                .toString() +
                                            ' '
                                        : '',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Direccion',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                tareas[index].clientAddress.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    "Dificultad",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      "BosCoins",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBarIndicator(
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.yellow),
                                    rating: double.parse(tareas[index].grade!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Text(
                                      (double.parse(tareas[index].grade!) * 100)
                                          .round()
                                          .toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              tareaAsignada.taskId != null ||
                                      tareas[index].completionDate != null
                                  ? Container()
                                  : MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      disabledColor: Colors.grey,
                                      elevation: 0,
                                      color: Colors.blueGrey[600],
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        final alumnoService =
                                            Provider.of<AlumnoService>(context,
                                                listen: false);
                                        QuickAlert.show(
                                            context: context,
                                            barrierDismissible: false,
                                            type: QuickAlertType.success,
                                            title: 'Completado',
                                            confirmBtnColor: Colors.blueGrey,
                                            text:
                                                'Tarea solicitada correctamente',
                                            confirmBtnText: 'Vale');
                                        await alumnoService.solicitarTarea(
                                            info[0].userId!,
                                            tareas[index].taskId!);

                                        setState(() {
                                          obtenerTareasAlumno();
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 15),
                                        child: const Text(
                                          'Solicitar',
                                          //loginForm.isLoading ? 'Wait' : 'Submit',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                    ),
                  );
                })),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }
}
