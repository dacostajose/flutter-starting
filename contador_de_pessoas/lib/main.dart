import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Contador de pessoas",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  void _changePeople(int delta) {
    setState(() {
      _people += delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Pessoas $_people",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: FlatButton(
                child: Text(
                  "adicionar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //_changePeople(1);
                  setState(() {
                    _people++;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: FlatButton(
                child: Text(
                  "remover",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //_changePeople(-1);
                  setState(() {
                    _people--;
                  });
                },
              ),
            ),
          ],
        ),
        Text(
          "Pode entrar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
