// ignore: depend_on_referenced_packages
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
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
  List<ProfesorData> profesores = [];
  List<CicloData> ciclos = [];
  obtenerProfesores() async {
    final adminService = Provider.of<AdminService>(context, listen: false);
    adminService.obtenerProfesores();
    setState(() {
      profesores = adminService.profesores;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerProfesores();
    getCiclos();
  }

  @override
  Widget build(BuildContext context) {
    final adminService = Provider.of<AdminService>(context);
    if (adminService.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Column(
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
                  title: Text('${profesor.firstname} ${profesor.surname}'),
                  subtitle: Text(''),
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
