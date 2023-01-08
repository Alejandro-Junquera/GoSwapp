import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  ScrollController scrollController = ScrollController();
  double topContainer = 0;
  var _isVisible = true;
  @override
  void initState() {
    super.initState();
    _isVisible = true;
    scrollController.addListener(() {
      //control Boton flotante
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
      //Control scroll
      double value = scrollController.offset / 300;

      setState(() {
        //control Boton flotante

        //Control scroll
        topContainer = value;
      });
    });
  }

  final listaOfertas = [
    _Oferta(
        'Arreglo de enchufe',
        'eeeeeeeeeeeeeeeeeeeeee eeeeeeeeee  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
        'enchufe.jpg',
        'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
    _Oferta('Arreglo de enchufe', 'se me ha roto el echufe necesito reparacion',
        'enchufe.jpg', 'electronica'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Usuario')),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          controller: scrollController,
          itemCount: listaOfertas.length,
          itemBuilder: (context, index) {
            final oferta = listaOfertas[index];
            double angle = index + 1 - topContainer;
            if (angle < 0) {
              angle = 0;
            } else if (angle > 1) {
              angle = 1;
            }
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.007)
                ..rotateX(angle - 1),
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                            right: 0,
                            top: 20,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 20.0,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/enchufe.jpg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Positioned(
                          left: 0,
                          top: 45,
                          child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.47,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(oferta.titulo,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: SizedBox(
                                      height: 120,
                                      child: Text(
                                        oferta.descripcion,
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Text('Estado : Finalizado')
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed('nuevaOfertaCliente'),
          tooltip: 'Añadir',
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//TODOO:BORRAR MAS TARDE
class _Oferta {
  String titulo;
  String descripcion;
  String imagen;
  String categoria;
  _Oferta(this.titulo, this.descripcion, this.imagen, this.categoria);
}
