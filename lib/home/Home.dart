// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../values/custom_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = TextEditingController();
  TextEditingController txtcidade = TextEditingController();
  TextEditingController txtuf = TextEditingController();
  TextEditingController txtbairro = TextEditingController();
  TextEditingController txtlogradouro = TextEditingController();
  TextEditingController txtcomplemento = TextEditingController();
  TextEditingController txtDDD = TextEditingController();

  String resultado = "Logradouro: ";

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
    String ddd = data["ddd"];

    var lista = [];
    lista.add("$cidade");
    lista.add("$uf");
    lista.add("$bairro");
    lista.add("$logradouro");
    lista.add("$complemento");
    lista.add("$ddd");
    lista.add("$cep");

    print(lista);

    setState(() {
      txtcidade.text = lista[0];
      txtuf.text = lista[1];
      txtbairro.text = lista[2];
      txtlogradouro.text = lista[3];
      txtcomplemento.text = lista[4];
      txtDDD.text = lista[5];
      txtcep.text = lista[6];

      print(lista);
    });
  }

  void limpaCampos() {
    if (txtcep.text.isEmpty) {
      txtcep.clear();
      txtuf.clear();
      txtcidade.clear();
      txtbairro.clear();
      txtlogradouro.clear();
      txtcomplemento.clear();
      txtDDD.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisar Endereço"),
        backgroundColor: Color.fromARGB(255, 63, 81, 181),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(right: 40, left: 40, top: 10, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ////
              const SizedBox(
                height: 50,
              ),
              _buildConsultaCep(),
              TextField(
                controller: txtuf,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "UF: ",
                  hintText: "ex: AM ",
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: txtcidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cidade: ",
                  hintText: "Ex: Manaus",
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: txtbairro,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bairro: ",
                  hintText: "Ex: Tiradentes",
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: txtlogradouro,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Logradouro: ",
                  hintText: "Ex: Rua Maceió",
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: txtcomplemento,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Complemento: ",
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: txtDDD,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "DDD: ",
                ),
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),

              //// ESSE BOTÃO DEVE SER DE SAIR
              ElevatedButton(
                child: Text(
                  "Sair",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: CustomColors().getActivePrimaryButton(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsultaCep() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 8,
            controller: txtcep,
            decoration: InputDecoration(
              counterText: "",
              labelText: "Digite seu CEP ",
              hintText: "ex: 01001000",
            ),
            style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.number,
            onTap: consultaCep,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 40,
          width: 60,
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            style: ElevatedButton.styleFrom(
              primary: CustomColors().getActivePrimaryButton(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              consultaCep();
              limpaCampos();
            },
          ),
        )
      ],
    );
  }
}
