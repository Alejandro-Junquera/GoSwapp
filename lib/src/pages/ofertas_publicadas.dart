import 'package:flutter/material.dart';

class OfertasPublicadasPage extends StatelessWidget {
  final listaOfertas = [
    _Oferta(
        'Cablear red',
        'Cablear una habitación con cable de red desde la habitación donde se encuentra el router',
        'enchufe.jpg',
        2),
    _Oferta(
        'Cambiar interruptor',
        'Modificar interruptor de corriente en mal estado debido a un golpe. Está roto',
        'enchufe.jpg',
        3),
    _Oferta(
        'Ordenador lento',
        'Necesito ayuda, desde hace unos dias mi ordenador va muy lento, quizas tenga un virus',
        'enchufe.jpg',
        1),
  ];

  OfertasPublicadasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {}, //(value) => _runFilter(value),
          decoration: const InputDecoration(
              labelText: '  Search', suffixIcon: Icon(Icons.search)),
        ),
        Expanded(
            child: ListView(
          children: [
            ...listaOfertas
                .map((oferta) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'ofertaconfig');
                      },
                      title: Row(
                        children: [
                          Text(oferta.titulo),
                          const Spacer(),
                          Text(oferta.intesesados.toString()),
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

//TODO: BORRAR EN UN FUTURO
class _Oferta {
  final String titulo;
  final String descripcion;
  final String imagen;
  final int intesesados;
  _Oferta(this.titulo, this.descripcion, this.imagen, this.intesesados);
}
