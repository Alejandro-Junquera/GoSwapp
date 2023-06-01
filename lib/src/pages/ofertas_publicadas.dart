import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/screens/oferta_config.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';

List<Widget> estado = <Widget>[
  const Text('Todas'),
  const Text('En proceso'),
  const Text('Finalizadas')
];

class OfertasPublicadasPage extends StatefulWidget {
  const OfertasPublicadasPage({super.key});

  @override
  State<OfertasPublicadasPage> createState() => _OfertasPublicadasPageState();
}

class _OfertasPublicadasPageState extends State<OfertasPublicadasPage> {
  List<bool> estadoSelecionado = <bool>[true, false, false];
  List<TareaDelCiclo> listaOfertasPublicadas = [];
  List<TareaDelCiclo> aux = [];

  obtenerTareasSinDificultad() async {
    final teacherService = Provider.of<TeacherService>(context, listen: false);
    await teacherService.obtenerTareasPublicadasDeUnCiclo();
    setState(() {
      listaOfertasPublicadas = teacherService.tareasProf;
      aux = listaOfertasPublicadas;
    });
  }

  Future refresh() async {
    obtenerTareasSinDificultad();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTareasSinDificultad();
  }

  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);
    if (teacherService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          SizedBox(
            height: 10,
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
                      setState(() {
                        listaOfertasPublicadas = aux;
                        listaOfertasPublicadas = listaOfertasPublicadas
                            .where((element) => element.completionDate == null)
                            .toList();
                      });
                      break;
                    case 2:
                      setState(() {
                        listaOfertasPublicadas = aux;
                        listaOfertasPublicadas = listaOfertasPublicadas
                            .where((element) => element.completionDate != null)
                            .toList();
                      });
                      break;
                    default:
                      setState(() {
                        listaOfertasPublicadas = aux;
                      });
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
              child: ListView(
            children: [
              ...listaOfertasPublicadas
                  .map((tarea) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          tileColor: tarea.completionDate != null
                              ? Colors.red[50]
                              : Colors.yellow[50],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  color: tarea.completionDate != null
                                      ? Colors.red
                                      : Colors.orange)),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OfertaConfigScreen(tarea: tarea),
                                ));
                          },
                          title: Row(
                            children: [
                              Text(tarea.title.toString()),
                              const Spacer(),
                              tarea.clientRating == null
                                  ? Text(tarea.requestCount != null
                                      ? tarea.requestCount.toString()
                                      : '0')
                                  : Text(''),
                              tarea.clientRating == null
                                  ? const Icon(Icons.person_outline)
                                  : double.parse(tarea.clientRating!) < 3
                                      ? const Icon(
                                          Icons.sentiment_dissatisfied_sharp)
                                      : const Icon(
                                          Icons.sentiment_satisfied_alt_sharp)
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ))
                  .toList()
            ],
          ))
        ],
      ),
    );
  }
}
