class SolicitudesTareas {
  String? estudiantesQueSolicitanLaTareaConId;
  List<SolicitudTarea>? estudiantes;

  SolicitudesTareas(
      {this.estudiantesQueSolicitanLaTareaConId, this.estudiantes});

  SolicitudesTareas.fromJson(Map<String, dynamic> json) {
    estudiantesQueSolicitanLaTareaConId =
        json['Estudiantes que solicitan la tarea con id'];
    if (json['Estudiantes'] != null) {
      estudiantes = <SolicitudTarea>[];
      json['Estudiantes'].forEach((v) {
        estudiantes!.add(new SolicitudTarea.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Estudiantes que solicitan la tarea con id'] =
        this.estudiantesQueSolicitanLaTareaConId;
    if (this.estudiantes != null) {
      data['Estudiantes'] = this.estudiantes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SolicitudTarea {
  int? id;
  String? studentName;
  String? surname;
  String? cicleStudent;
  String? assignedAt;

  SolicitudTarea(
      {this.id,
      this.studentName,
      this.surname,
      this.cicleStudent,
      this.assignedAt});

  SolicitudTarea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentName = json['student_name'];
    surname = json['surname'];
    cicleStudent = json['cicle_student'];
    assignedAt = json['assigned_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_name'] = this.studentName;
    data['surname'] = this.surname;
    data['cicle_student'] = this.cicleStudent;
    data['assigned_at'] = this.assignedAt;
    return data;
  }
}
