// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_aplicacion_ganadora/models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/services.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  List<TareasDataUser> misTareas = [];
  obtenerTareasUsuario() async {
    final userService = Provider.of<UserService>(context, listen: false);
    await userService.obtenerTareasUsuario();
    setState(() {
      misTareas = userService.misTareas;
    });
  }

  ScrollController scrollController = ScrollController();
  double topContainer = 0;
  var _isVisible = true;
  @override
  void initState() {
    super.initState();
    obtenerTareasUsuario();
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

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UserService>(context);
    if (usuarioService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Usuario'),
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
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          controller: scrollController,
          itemCount: misTareas.length,
          itemBuilder: (context, index) {
            final tarea = misTareas[index];
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
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, "infoOfertaCliente",
                                    arguments: tarea),
                                child: Hero(
                                  tag: tarea.id!,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      tarea.imagen == ''
                                          ? 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'
                                          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: tarea.completionDate != null
                                          ? Colors.green
                                          : Colors.orange)),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(tarea.title.toString(),
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
                                        tarea.description.toString(),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  tarea.completionDate != null
                                      ? Text('Tarea finalizada')
                                      : Text('En proceso')
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
  String estado;
  _Oferta(
      this.titulo, this.descripcion, this.imagen, this.categoria, this.estado);
}
