import 'dart:io';

//import 'package:contatosapp/pages/contato_altera_page.dart';
import 'package:contatosapp/pages/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:contatosapp/repositories/contato_back_repository.dart';
import '../../../models/contato_back_model.dart';

class ContatoBackPage extends StatefulWidget {
  const ContatoBackPage({super.key});

  @override
  State<ContatoBackPage> createState() => _ContatoBackPageState();
}

class _ContatoBackPageState extends State<ContatoBackPage> {
  ContatosBackRepositoy contatobackRepository = ContatosBackRepositoy();
  var _contatosBack = ContatosBackModel();
  final contatoBack = ContatoBackModel();
  var contatoContoller = TextEditingController();
  var carregando = false;
  int id = 0;


  @override
  void initState() {
    super.initState();
    obterContato();
  }

  void obterContato() async {
    setState(() {
      carregando = true;
    });
    _contatosBack =  await contatobackRepository.obterContato();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.amber, Colors.orange]
                )
            ),
            //margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("lib/images/contatos.png", height: 120,),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Gerenciador de Contatos",
                        style: TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.w800, 
                          shadows: [
                                Shadow(
                                  color: Colors.grey,      // Choose the color of the shadow
                                  blurRadius: 2.0,          // Adjust the blur radius for the shadow effect
                                  offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ],
                         // color: Color.fromARGB(255, 70, 69, 69),
                          ),
                                            ),
                      ),
                  ]),
                ),
                carregando
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemCount: _contatosBack.contatos.length,
                            itemBuilder: (BuildContext bc, int index) {
                              var contato = _contatosBack.contatos[index];
                              return Dismissible(
                                onDismissed:
                                    (DismissDirection dismissDirection) async {
                                  await contatobackRepository.remover(contato.objectId!);
                                  obterContato();
                                },
                                key: Key(contato.objectId!),
                                child: Card(
                                  elevation: 10,
                                  child: ListTile(
                                    title: Text("${contato.nomeContato}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600 ),),
                                    subtitle: Text(contato.foneContato!),
                                    leading: SizedBox(
                                      height: 100.0,
                                      child: 
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.file(File(contato.fotoContato!)),
                                    )),
                                   onTap: () {
                                      // Navigator.pop(context);
                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(builder: (_) =>
                                      // ContatoAlteraPage(objectId: contato.objectId!,)));                  
                                   },
                                  ),
                                ),
                                
                              );
                            }),
                      ),
              ],
            ),
          ),
            floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
              const ContatoPage()));
            },
         
          )),
    );
    
  }
}