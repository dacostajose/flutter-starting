import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesocontroller = TextEditingController();
  TextEditingController alturacontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetField() {
    alturacontroller.text = "";
    pesocontroller.text = "";
    setState(() {
      _textInfo = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    double peso = double.parse(pesocontroller.text);
    double altura = double.parse(alturacontroller.text) / 100;
    double imc = peso / (altura * altura);
    setState(() {
      _textInfo = "Seu imc é igual a ${imc.toStringAsPrecision(3)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 100.0,
                    color: Colors.blueGrey,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                    controller: pesocontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.blueGrey),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                      controller: alturacontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculateIMC();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Text("$_textInfo",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 25.0))
                ],
              ),
            )));
  }
}
