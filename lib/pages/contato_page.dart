import 'dart:async';
import 'dart:io';
import 'package:contatosapp/models/contato_back_model.dart';
import 'package:contatosapp/pages/contato_back_page.dart';
import 'package:contatosapp/repositories/contato_back_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  bool salvando = false;
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var emailController = TextEditingController(text: "");
  var foneController = TextEditingController(text: "");
  var fotoController = TextEditingController(text: "/data/user/0/com.monicakkc.contatosapp.contatosapp/app_flutter/nouser.jpg");
  ContatosBackRepositoy contatosbackRepository = ContatosBackRepositoy();
  final _contatosBack = ContatosBackModel();
  int id = 0;
  XFile? photo;
  var _imagem = "/data/user/0/com.monicakkc.contatosapp.contatosapp/app_flutter/nouser.jpg";
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

 void refreshData() {
    id++;
  }

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await ImageGallerySaver.saveFile(croppedFile.path);
      //ImageGallerySaver.saveImage(Uint8List.fromList(response.data)
      photo = XFile(croppedFile.path);
      setState(() {});
    }
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Incluir Contato",
                style: TextStyle(fontSize: 18)),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.amber, Colors.orange]
                )
            ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal:16),
            child: 
              salvando 
              ? const Center(child: CircularProgressIndicator())
              : Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text("Camera"),
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      photo = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      if (photo != null) {
                                        String path = (await path_provider
                                                .getApplicationDocumentsDirectory())
                                            .path;
                                        String name = basename(photo!.path);
                                        await photo!.saveTo("$path/$name");
          
                                        await ImageGallerySaver.saveFile(photo!.path);      
                                        fotoController.text = ("$path/$name");
            
                                        setState(() {
                                          _imagem = photo.toString();                              
                                        });
                                 
                                       //cropImage(photo!);
                                      }
                                    },
                                  ),
                                  ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text("Galeria"),
                                      onTap: () async {
                                        final ImagePicker _picker = ImagePicker();
                                        photo = await _picker.pickImage(
                                            source: ImageSource.gallery);
                                        if (photo != null) {
                                          String path = (await path_provider
                                                  .getApplicationDocumentsDirectory())
                                              .path;
                                          String name = basename(photo!.path);
                                          await photo!.saveTo("$path/$name");
          
                                          await ImageGallerySaver.saveFile(photo!.path);      
                                          fotoController.text = ("$path/$name");
                                          setState(() {
                                            _imagem = fotoController.text;                                             
                                          });                          
                                  //      Navigator.pop(context);
                                 
                                  //      cropImage(photo!);
                                      }
                                      })
                                     ],);
                                  });
                                },
                          child: 
                          Column(
                            children: [
                              photo != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.file(File(photo!.path),height: 120,))
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("lib/images/nophoto.jpg", height: 120,))
                            ],
                          ),),
                          const Text("Nome: "),
                          TextFormField(
                            controller: nomeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder()),                
                          ),
                          const SizedBox(height: 15),
                          const Text("Telefone: "),
                          TextFormField(
                            inputFormatters: [maskFormatter],
                            keyboardType: TextInputType.phone,
                            controller: foneController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(), ),                
                          ),
                          const SizedBox(height: 15),
                          const Text("Email"),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                            border: OutlineInputBorder()),               
                          ),
                          const SizedBox(height: 15),               
                          const Text("Data de Nascimento"),
                          TextFormField(
                            controller: dataNascimentoController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder()),                      
                            onTap: () async {
                              var data = await showDatePicker (
                                context: context, 
                                initialDate: DateTime(2000, 1, 1),
                                firstDate: DateTime(1900, 5, 20), 
                                lastDate: DateTime(2023, 10, 23));
                              if (data != null) {
                                dataNascimentoController.text = data.toString();
                                dataNascimento = data;
                              }
                            },
                          ),
                          const SizedBox(height: 15), 
                          Expanded(
                            child: Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                  },
                                child: const Text("Cancelar")),
                                TextButton(onPressed: () async {
                                  setState(() {
                                    salvando = false;
                                  });
                                  if (nomeController.text.trim().length < 3) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Preencha o nome corretamente")));
                                    return;
                                  }
                                  if (foneController.text.trim().length < 3) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Preencha o telefone corretamente")));
                                    return;
                                  } 
                                  final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text); 
                                  if (!emailValid){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Preencha o email corretamente")));
                                      return;                     
                                  }
                                  if (dataNascimento == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Data de nascimento inválida")));
                                    return;
                                  }
                                  await contatosbackRepository.criar(ContatoBackModel.criar(
                                    nomeController.text, foneController.text, emailController.text, fotoController.text, dataNascimentoController.text));
                                  setState(() {
                                    salvando = true;
                                  });
                          
                                  Future.delayed(const Duration(seconds: 2), () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                      content: Text("Dados salvos com sucesso")));
                                    setState(() {
                                      salvando = false;
                                    });
          
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                          const ContatoBackPage())).then(onGoBack);
                                    //Navigator.pop(context);                      
                                  });                              
                                }, child: const Text("Salvar")),
                              ],
                            ),
                          ),
                        ]),
                ),
              )
          ),
        ))
    );
  }
}
