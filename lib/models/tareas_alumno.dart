class TareasAlumno {
  EstudianteInfo? estudiante;
  List<TareasAlumnoCiclo>? tareas;
  List<TareasAsignadasAlumno>? tareasAsignadas;

  TareasAlumno({this.estudiante, this.tareas, this.tareasAsignadas});

  TareasAlumno.fromJson(Map<String, dynamic> json) {
    estudiante = json['estudiante'] != null
        ? new EstudianteInfo.fromJson(json['estudiante'])
        : null;
    if (json['tareas'] != null) {
      tareas = <TareasAlumnoCiclo>[];
      json['tareas'].forEach((v) {
        tareas!.add(new TareasAlumnoCiclo.fromJson(v));
      });
    }
    if (json['tareas_asignadas'] != null) {
      tareasAsignadas = <TareasAsignadasAlumno>[];
      json['tareas_asignadas'].forEach((v) {
        tareasAsignadas!.add(new TareasAsignadasAlumno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.estudiante != null) {
      data['estudiante'] = this.estudiante!.toJson();
    }
    if (this.tareas != null) {
      data['tareas'] = this.tareas!.map((v) => v.toJson()).toList();
    }
    if (this.tareasAsignadas != null) {
      data['tareas_asignadas'] =
          this.tareasAsignadas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EstudianteInfo {
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

  EstudianteInfo(
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
      this.updatedAt});

  EstudianteInfo.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class TareasAlumnoCiclo {
  int? taskId;
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
  int? clientRating;

  TareasAlumnoCiclo(
      {this.taskId,
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

  TareasAlumnoCiclo.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    title = json['title'];
    numBoscoins = json['num_boscoins'];
    description = json['description'];
    cicleId = json['cicle_id'];
    userId = json['user_id'];
    grade = json['grade'].toString();
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
    data['task_id'] = this.taskId;
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

class TareasAsignadasAlumno {
  int? id;
  int? studentId;
  String? studentName;
  String? cicleStudent;
  int? taskId;
  int? teacherId;
  String? assignedAt;
  String? dueDate;
  String? completedAt;
  String? feedback;
  String? createdAt;
  String? updatedAt;
  int? cicleId;

  TareasAsignadasAlumno(
      {this.id,
      this.studentId,
      this.studentName,
      this.cicleStudent,
      this.taskId,
      this.teacherId,
      this.assignedAt,
      this.dueDate,
      this.completedAt,
      this.feedback,
      this.createdAt,
      this.updatedAt,
      this.cicleId});

  TareasAsignadasAlumno.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    studentName = json['student_name'];
    cicleStudent = json['cicle_student'];
    taskId = json['task_id'];
    teacherId = json['teacher_id'];
    assignedAt = json['assigned_at'];
    dueDate = json['due_date'];
    completedAt = json['completed_at'];
    feedback = json['feedback'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cicleId = json['cicle_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    data['cicle_student'] = this.cicleStudent;
    data['task_id'] = this.taskId;
    data['teacher_id'] = this.teacherId;
    data['assigned_at'] = this.assignedAt;
    data['due_date'] = this.dueDate;
    data['completed_at'] = this.completedAt;
    data['feedback'] = this.feedback;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cicle_id'] = this.cicleId;
    return data;
  }
}
