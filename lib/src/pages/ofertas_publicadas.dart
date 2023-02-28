import 'package:flutter/material.dart';
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
  List<TareasDataUser> listaOfertasPublicadas = [];
  obtenerTareasSinDificultad() async {
    final teacherService = Provider.of<TeacherService>(context, listen: false);
    await teacherService.obtenerTareasPublicadasDeUnCiclo();
    setState(() {
      listaOfertasPublicadas = teacherService.tareasProf;
    });
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
    return Column(
      children: [
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < estado.length; i++) {
                estadoSelecionado[i] = i == index;
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
                .map((tarea) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'ofertaconfig');
                      },
                      title: Row(
                        children: [
                          Text(tarea.title.toString()),
                          const Spacer(),
                          const Text('falta info Api'),
                          const Icon(Icons.person_outline)
                        ],
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ))
                .toList()
          ],
        ))
      ],
    );
  }
}
