// ignore: depend_on_referenced_packages
import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTareasSinCiclo();
    getCiclos();
  }

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final adminService = Provider.of<AdminService>(context);
    if (adminService.isLoading)
      return Center(child: CircularProgressIndicator());
    return Column(
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
                    onPressed: (BuildContext context) {},
                    backgroundColor: Colors.green,
                    icon: Icons.check,
                  ),
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      //EnsPoint delete
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  ),
                ]),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      border: Border.all(color: Colors.blueGrey, width: 2),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 210,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('${tarea.title}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: SizedBox(
                          height: 95,
                          child: Text(
                            tarea.description.toString(),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Form(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey))),
                          hint: const Text('Select a cicle'),
                          items: ciclos.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            registerForm.ciclos_id = value!;
                          },
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
    );
  }
}
