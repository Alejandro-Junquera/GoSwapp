class Alumnos {
  List<AlumnoPerfilData>? estudiantes;

  Alumnos({this.estudiantes});

  Alumnos.fromJson(Map<String, dynamic> json) {
    if (json['Estudiantes'] != null) {
      estudiantes = <AlumnoPerfilData>[];
      json['Estudiantes'].forEach((v) {
        estudiantes!.add(new AlumnoPerfilData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.estudiantes != null) {
      data['Estudiantes'] = this.estudiantes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlumnoPerfilData {
  int? id;
  int? userId;
  String? firstname;
  String? surname;
  String? email;
  String? password;
  String? type;
  int? boscoins;
  String? address;
  String? mobile;
  int? cicleId;
  String? createdAt;
  String? updatedAt;
  String? cicleName;

  AlumnoPerfilData(
      {this.id,
      this.userId,
      this.firstname,
      this.surname,
      this.email,
      this.password,
      this.type,
      this.boscoins,
      this.address,
      this.mobile,
      this.cicleId,
      this.createdAt,
      this.updatedAt,
      this.cicleName});

  AlumnoPerfilData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    boscoins = json['boscoins'];
    address = json['address'];
    mobile = json['mobile'];
    cicleId = json['cicle_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cicleName = json['cicleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['boscoins'] = this.boscoins;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['cicle_id'] = this.cicleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cicleName'] = this.cicleName;
    return data;
  }
}
