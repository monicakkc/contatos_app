import 'package:contatosapp/models/contato_back_model.dart';
import 'package:contatosapp/repositories/contato_back_repository.dart';
import 'package:flutter/material.dart';

class ContatoAlteraPage extends StatefulWidget {
  String objectId;
  ContatoAlteraPage({super.key, required this.objectId});

  @override
  State<ContatoAlteraPage> createState() => _ContatoAlteraPageState();
}

class _ContatoAlteraPageState extends State<ContatoAlteraPage> {

  ContatosBackRepositoy contatosbackRepository = ContatosBackRepositoy();
  final contatoBack = ContatoBackModel();
  var carregando = false;
  var _contatosBack = ContatosBackModel();
  var contatos = <ContatosBackModel>[];
  ContatosBackRepositoy contatobackRepository = ContatosBackRepositoy();

  @override
  void initState() {
    super.initState();
    obterContato();
  }

  void obterContato() async {
    setState(() {
      carregando = true;
    });
    _contatosBack =  await contatobackRepository.buscarContato(widget.objectId);
    setState(() {
      carregando = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Detalhes do Contato",
                style: TextStyle(fontSize: 18)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal:16),
          child: 
           Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                        const Text("Nome: "),
                        Text(contatoBack.nomeContato!),
                        const SizedBox(height: 15),
                        const Text("Telefone: "),
                        Text(contatoBack.foneContato!),
                        const SizedBox(height: 15),
                        const Text("Email"),
                        Text(contatoBack.emailContato!),
                        const SizedBox(height: 15),               
                        const Text("Data de Nascimento"),
                        Text(contatoBack.aniversarioContato!),
                        const SizedBox(height: 15), 
                        Expanded(
                          child: Row(
                            children: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                },
                              child: const Text("Voltar")),

                            ],
                          ),
                        ),
                      ]),
              ),
            )
        ))
    );
  }
}
