import 'package:contatosapp/models/contato_back_model.dart';
import 'back_custom_dio.dart';


class ContatosBackRepositoy {
  final _customDio = BackCustomDio();

  ContatosBackRepositoy();

  Future<ContatosBackModel> obterContato() async {
    var url = "/contatos";
    var result = await _customDio.dio.get(url);
    return ContatosBackModel.fromJson(result.data);
  }

  Future<ContatosBackModel> buscarContato(String objectId) async {
    var url = "/contatos/$objectId/json";
    var result = await _customDio.dio.get(url);
    return ContatosBackModel.fromJson(result.data);
  }


  Future<void> criar(ContatoBackModel contatoBackModel) async {
    try {
      await _customDio.dio
          .post("/contatos", data: contatoBackModel.toJsonEndpoint()); //.toJsonEndpoint()
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(ContatoBackModel contatoBackModel) async {
    try {
      var response = await _customDio.dio.put(
          "/contatos/${contatoBackModel.objectId}", //.objectId
          data: contatoBackModel.toJson()); //.toJsonEndpoint()
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      var response = await _customDio.dio.delete(
        "/contatos/$objectId",
      );
    } catch (e) {
      rethrow;
    }
  }
}
