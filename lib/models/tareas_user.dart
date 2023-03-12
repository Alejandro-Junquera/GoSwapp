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
  String? grade;
  String? imagen;
  String? createdAt;
  String? updatedAt;
  String? completionDate;
  String? comment;
  String? clientAddress;
  String? clientPhone;
  String? clientRating;

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
      this.updatedAt,
      this.completionDate,
      this.comment,
      this.clientAddress,
      this.clientPhone,
      this.clientRating});

  TareasDataUser.fromJson(Map<String, dynamic> json) {
    id = json['task_id'];
    title = json['title'];
    numBoscoins = json['num_boscoins'];
    description = json['description'];
    cicleId = json['cicle_id'];
    userId = json['user_id'];
    grade = json['grade'];
    imagen = json['imagen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    completionDate = json['completion_date'];
    comment = json['comment'];
    clientAddress = json['client_address'];
    clientPhone = json['client_phone'];
    clientRating = json['client_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.id;
    data['title'] = this.title;
    data['num_boscoins'] = this.numBoscoins;
    data['description'] = this.description;
    data['cicle_id'] = this.cicleId;
    data['user_id'] = this.userId;
    data['grade'] = this.grade;
    data['imagen'] = this.imagen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['completion_date'] = this.completionDate;
    data['comment'] = this.comment;
    data['client_address'] = this.clientAddress;
    data['client_phone'] = this.clientPhone;
    data['client_rating'] = this.clientRating;
    return data;
  }
}
