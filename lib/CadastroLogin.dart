import 'package:cadastro_clientes/Login.dart';
import 'package:cadastro_clientes/values/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Home.dart';
import 'TrataTextTelefone.dart';

class CadastroLogin extends StatefulWidget {
  const CadastroLogin({Key? key}) : super(key: key);

  @override
  State<CadastroLogin> createState() => _CadastroLoginState();
}

class _CadastroLoginState extends State<CadastroLogin> {
  TextEditingController txtnome = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtsenha = TextEditingController();

  bool showPassword = false;

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
                "Cadastrar-se",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Nome",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.perm_identity_rounded,
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
                      autofocus: true,
                      obscureText: (showPassword == true) ? false : true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.key_sharp,
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

                    /// OPERADOR TERNARIO /////
                    (showPassword == false)
                        ? TextFormField(
                            autofocus: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Confirmar Senha",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.key_sharp,
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
                          )
                        : Container(),

                    /// FIM OPERADOR TERNARIO ////
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: showPassword,
                          onChanged: (bool? newValue) {
                            setState(
                              () {
                                showPassword = newValue!;
                              },
                            );
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          "Mostrar senha",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // ESQUECEU A SENHA

              const SizedBox(
                height: 10,
              ),

              /////
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Salvar",
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
}
