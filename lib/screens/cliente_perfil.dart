import 'package:flutter/material.dart';

class ClientePerfilScreen extends StatefulWidget {
  const ClientePerfilScreen({super.key});

  @override
  State<ClientePerfilScreen> createState() => _ClientePerfilScreenState();
}

class _ClientePerfilScreenState extends State<ClientePerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Perfil"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    './assets/images/iconoCliente.png',
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: true,
            controller: TextEditingController()
              ..text = 'Pablo Alfonso Gonzalez Diaz',
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                enabled: false,
                label: Text('Nombre Completo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              readOnly: true,
              controller: TextEditingController()..text = '658213685',
              maxLines: 1,
              decoration: const InputDecoration(
                  disabledBorder: OutlineInputBorder(),
                  enabled: false,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueGrey,
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            readOnly: true,
            controller: TextEditingController()
              ..text = 'Pablo Alfonso Gonzalez Diaz',
            maxLines: 1,
            decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(),
                enabled: false,
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                )),
          ),
        )
      ]),
    );
  }
}
