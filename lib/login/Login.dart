import 'dart:convert';

import 'package:cadastro_clientes/home/Home.dart';
import 'package:cadastro_clientes/models/LoginModel.dart';
import 'package:cadastro_clientes/values/custom_colors.dart';
import 'package:cadastro_clientes/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cadastro/CadastroLogin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // CONTROLADORES
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(right: 40, left: 40, top: 130, bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              CustomColors().gettopColor(),
              CustomColors().getbottomColor(),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "campo obrigatório";
                        } else if (!value.contains("@")) {
                          return 'email inválido';
                        }
                        return null;
                      },
                      controller: _mailInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return "senha deve conter 6 caracteres";
                        }
                      },
                      obscureText: _obscureText,
                      controller: _passwordInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                    ),
                  ],
                ),
              ),
              // ESQUECEU A SENHA
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              GestureDetector(
                onTap: () {
                  print("funciona");
                },
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _obscureText,
                    onChanged: (bool? newValue) {
                      setState(
                        () {
                          _obscureText = newValue!;
                        },
                      );
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text(
                    "Continuar conectado?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              ElevatedButton(
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () {
                  _doLogin();
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomColors().getActivePrimaryButton(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ), // fim botao
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: Colors.black),
              ),

              const SizedBox(
                height: 8,
              ),

              ///
              const Text(
                "Ainda não tem uma conta?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              /////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CadastroLogin()));
                  },
                  child: const Text(
                    "Cadastre-se",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors().getActiveSecondButton(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ), // fim botao
                ),
              ),

              ///
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() async {
    if (_formKey.currentState!.validate()) {
      print("válido");
    } else {
      print("inválido");
    }
    String mailForm = _mailInputController.text;
    String passForm = _passwordInputController.text;
    LoginModel savedUser = await _getSavedUser();

    if (mailForm == savedUser.mail && passForm == savedUser.password) {
      print("LOGIN EFETUADO COM SUCESSO!");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print("DADOS INVÁLIDOS");
    }
  }

  Future<LoginModel> _getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(PreferencesKeys.activeUser);
    print(jsonUser);
    Map<String, dynamic> mapUser = json.decode(jsonUser!);
    LoginModel user = LoginModel.fromJson(mapUser);
    return user;
  }
}
