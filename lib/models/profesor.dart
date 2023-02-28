class Profesores {
  List<ProfesorData>? profesores;

  Profesores({this.profesores});

  Profesores.fromJson(Map<String, dynamic> json) {
    if (json['Profesores'] != null) {
      profesores = <ProfesorData>[];
      json['Profesores'].forEach((v) {
        profesores!.add(ProfesorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profesores != null) {
      data['Profesores'] = profesores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfesorData {
  int? id;
  String? firstname;
  String? surname;
  String? email;
  String? password;
  String? type;
  String? address;
  String? mobile;
  int? cicleId;
  String? createdAt;
  String? updatedAt;

  ProfesorData(
      {this.id,
      this.firstname,
      this.surname,
      this.email,
      this.password,
      this.type,
      this.address,
      this.mobile,
      this.cicleId,
      this.createdAt,
      this.updatedAt});

  ProfesorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    address = json['address'];
    mobile = json['mobile'];
    cicleId = json['cicle_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['surname'] = surname;
    data['email'] = email;
    data['password'] = password;
    data['type'] = type;
    data['address'] = address;
    data['mobile'] = mobile;
    data['cicle_id'] = cicleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
