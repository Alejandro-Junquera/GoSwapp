class TareasUser {
  List<TareasDataUser>? tareas;

  TareasUser({this.tareas});

  TareasUser.fromJson(Map<String, dynamic> json) {
    if (json['Tareas'] != null) {
      tareas = <TareasDataUser>[];
      json['Tareas'].forEach((v) {
        tareas!.add(TareasDataUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tareas != null) {
      data['Tareas'] = tareas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TareasDataUser {
  int? id;
  String? title;
  int? numBoscoins;
  String? description;
  int? cicleId;
  int? userId;
  double? grade;
  String? imagen;
  String? createdAt;
  String? updatedAt;

  TareasDataUser(
      {this.id,
      this.title,
      this.numBoscoins,
      this.description,
      this.cicleId,
      this.userId,
      this.grade,
      this.imagen,
      this.createdAt,
      this.updatedAt});

  TareasDataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    numBoscoins = json['num_boscoins'];
    description = json['description'];
    cicleId = json['cicle_id'];
    userId = json['user_id'];
    grade = json['grade'];
    imagen = json['imagen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['num_boscoins'] = numBoscoins;
    data['description'] = description;
    data['cicle_id'] = cicleId;
    data['user_id'] = userId;
    data['grade'] = grade;
    data['imagen'] = imagen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
