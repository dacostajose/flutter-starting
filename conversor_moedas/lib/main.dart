import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> _getData() async {
  http.Response resposta = await http
      .get("https://api.hgbrasil.com/finance?format=json&key=a99634c2");

  return json.decode(resposta.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    if (text == "" || text == null) {
      dolarController.text = "";
      euroController.text = "";
    }
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    double real = dolar * this.dolar;
    realController.text = (real).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    if (text == "" || text == null) {
      realController.text = "";
      euroController.text = "";
    }
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    double real = euro * this.euro;
    realController.text = (real).toStringAsFixed(2);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    if (text == "" || text == null) {
      realController.text = "";
      dolarController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: _getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados"),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar dados"),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 120.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          border: OutlineInputBorder(),
                          prefixText: "R\$",
                        ),
                        controller: realController,
                        onChanged: _realChanged,
                        keyboardType: TextInputType.number,
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Dolar",
                          border: OutlineInputBorder(),
                          prefixText: "US\$",
                        ),
                        controller: dolarController,
                        onChanged: _dolarChanged,
                        keyboardType: TextInputType.number,
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Euros",
                          border: OutlineInputBorder(),
                          prefixText: "€U",
                        ),
                        controller: euroController,
                        onChanged: _euroChanged,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
