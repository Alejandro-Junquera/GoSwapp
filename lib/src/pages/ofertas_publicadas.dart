import 'package:flutter/material.dart';

class OfertasPublicadasPage extends StatelessWidget {
  final listaOfertas = [
    _Oferta('Cambio Enchufe', 'NECESITO CAMBIAR UN ENCHUFE', 'enchufe.jpg'),
    _Oferta('Pintar paredes', 'nueva mano de pintura', 'enchufe.jpg'),
    _Oferta('Cambio Enchufe', 'NECESITO CAMBIAR UN ENCHUFE', 'enchufe.jpg'),
    _Oferta('Pintar paredes', 'nueva mano de pintura', 'enchufe.jpg')
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
                          Text("5"),
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
  _Oferta(this.titulo, this.descripcion, this.imagen);
}
