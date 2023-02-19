// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class GestionarProfesoresPage extends StatefulWidget {
  const GestionarProfesoresPage({super.key});

  @override
  State<GestionarProfesoresPage> createState() =>
      _GestionarProfesoresPageState();
}

class _GestionarProfesoresPageState extends State<GestionarProfesoresPage> {
  final listaProfesores = [
    _Profesor(1, 'Pepe', 'Martinez', 'DAM'),
    _Profesor(2, 'Felipe', 'Juanes', 'DAW'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          itemCount: listaProfesores.length,
          itemBuilder: ((context, index) {
            final profesor = listaProfesores[index];
            return Slidable(
              startActionPane:
                  ActionPane(motion: const DrawerMotion(), children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                ),
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.blue,
                  icon: Icons.edit,
                ),
              ]),
              child: Container(
                height: 70,
                color: Colors.grey[400],
                child: ListTile(
                  title: Text('${profesor.nombre} ${profesor.apellidos}'),
                  subtitle: Text(profesor.ciclo),
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
            onPressed: () {
              Navigator.of(context).pushNamed('crearProfesor');
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _Profesor {
  final int id;
  final String nombre;
  final String apellidos;
  final String ciclo;
  _Profesor(this.id, this.nombre, this.apellidos, this.ciclo);
}
