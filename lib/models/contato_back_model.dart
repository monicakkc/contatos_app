


class ContatosBackModel {
  List<ContatoBackModel> contatos = [];

  ContatosBackModel({contatos});

  ContatosBackModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoBackModel>[];
      json['results'].forEach((v) {
        contatos.add(ContatoBackModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}



class ContatoBackModel {
  String? objectId;
  String? nomeContato;
  String? foneContato;
  String? emailContato;
  String? fotoContato;
  String? aniversarioContato;


  ContatoBackModel(
      {this.objectId,
      this.nomeContato,
      this.foneContato,
      this.emailContato,
      this.fotoContato,
      this.aniversarioContato});

  ContatoBackModel.criar(
      this.nomeContato,
      this.foneContato,
      this.emailContato,
      this.fotoContato,
      this.aniversarioContato,
);

  ContatoBackModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nomeContato = json['nomeContato'];
    foneContato = json['foneContato'];
    emailContato = json['emailContato'];
    fotoContato = json['fotoContato'];
    aniversarioContato = json['aniversarioContato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nomeContato'] = nomeContato;
    data['foneContato'] = foneContato;
    data['emailContato'] = emailContato;
    data['fotoContato'] = fotoContato;
    data['aniversarioContato'] = aniversarioContato;    
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomeContato'] = nomeContato;
    data['foneContato'] = foneContato;
    data['emailContato'] = emailContato;
    data['fotoContato'] = fotoContato;
    data['aniversarioContato'] = aniversarioContato;
    return data;
  }

}
