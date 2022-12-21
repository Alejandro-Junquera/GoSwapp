import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: FractionallySizedBox(
        widthFactor: 0.98,
        heightFactor: 0.98,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 1, 63, 91),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/trueque.png")),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                child: Text(
                  'Login',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 92, vertical: 15),
                child: Text(
                  'Registro',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
