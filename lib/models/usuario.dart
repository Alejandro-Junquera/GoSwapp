class Usuario {
  Usuario? usuario;

  Usuario({this.usuario});

  Usuario.fromJson(Map<String, dynamic> json) {
    usuario =
        json['Usuario'] != null ? new Usuario.fromJson(json['Usuario']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.usuario != null) {
      data['Usuario'] = this.usuario!.toJson();
    }
    return data;
  }
}

class UsuarioData {
  int? id;
  String? firstname;
  String? surname;
  String? email;
  String? type;
  String? address;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  UsuarioData(
      {this.id,
      this.firstname,
      this.surname,
      this.email,
      this.type,
      this.address,
      this.mobile,
      this.createdAt,
      this.updatedAt});

  UsuarioData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    type = json['type'];
    address = json['address'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['type'] = this.type;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
