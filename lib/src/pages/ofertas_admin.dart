// ignore: depend_on_referenced_packages
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
  final listaOfertas = [
    _Oferta(
        titulo: 'Ordenador lento',
        descripcion:
            'Necesito ayuda, desde hace unos dias mi ordenador va muy lento, quizas tenga un virus',
        imagen: 'enchufe.jpg'),
    _Oferta(
        titulo: 'Cambio de cableado electrico',
        descripcion:
            'Buenos dias necesito ayuda para cambiar el cableado electrico de una habitación debido a la humedad',
        imagen: 'enchufe.jpg'),
  ];
  final listaCiclos = [
    _Ciclo(1, 'DAM'),
    _Ciclo(2, 'IEA'),
  ];
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: listaOfertas.length,
            itemBuilder: ((context, index) {
              final oferta = listaOfertas[index];
              return Slidable(
                key: Key(oferta.titulo),
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      oferta.ciclo_id = registerForm.ciclos_id;
                      if (oferta.ciclo_id == 0) {
                        print('mal');
                      } else {
                        //endpoint asignar
                        registerForm.ciclos_id = 0;
                      }
                    },
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
                          child: Text('${oferta.titulo}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: SizedBox(
                          height: 95,
                          child: Text(
                            oferta.descripcion,
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
                          items: listaCiclos.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.nombre.toString()),
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

class _Oferta {
  String titulo;
  String descripcion;
  String imagen;
  int? ciclo_id;
  _Oferta(
      {required this.titulo,
      required this.descripcion,
      required this.imagen,
      this.ciclo_id});
}

class _Ciclo {
  final int id;
  final String nombre;
  _Ciclo(this.id, this.nombre);
}
