import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:contatosapp/pages/myapp.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: "windows/.env");
  var documentDirectory = 
    await path_provider.getApplicationDocumentsDirectory();
  runApp(const MyApp());
}
