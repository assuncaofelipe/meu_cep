// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = TextEditingController();

  //
  String resultado = "Seu cep aparecerá aqui";

  void consultaCep() async {
    String cep = txtcep.text;
    String url = "https://viacep.com.br/ws/$cep/json/";

    http.Response response = await http.get(Uri.parse(url));

    // console
    print("Resposta: " + response.body);
    print("StatusCode: " + response.statusCode.toString());

    Map<String, dynamic> data = jsonDecode(response.body);

    String codeCep = data["cep"];
    String uf = data["uf"];
    String cidade = data["localidade"];
    String bairro = data["bairro"];
    String logradouro = data["logradouro"];
    String complemento = data["complemento"];
    String cod_area = data["ddd"];

    String endereco =
        "Endereço:  $cidade, $uf, $bairro, $logradouro, $complemento, \nCEP: $cep, \nCódigo de área: $cod_area";

    setState(() {
      resultado = endereco;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Cep'),
        backgroundColor: Color.fromARGB(255, 63, 81, 181),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            ////
            TextField(
              controller: txtcep,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP ex: 01001000",
              ),
              style: TextStyle(fontSize: 20),
            ),
            ////
            const SizedBox(
              height: 50,
            ),
            Text(
              "$resultado",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text(
                "Consultar CEP",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: consultaCep,
            ),
          ],
        ),
      ),
    );
  }
}
