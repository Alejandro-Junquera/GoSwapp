class Ciclos {
  List<CicloData>? ciclos;

  Ciclos({this.ciclos});

  Ciclos.fromJson(Map<String, dynamic> json) {
    if (json['Ciclos'] != null) {
      ciclos = <CicloData>[];
      json['Ciclos'].forEach((v) {
        ciclos!.add(CicloData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ciclos != null) {
      data['Ciclos'] = this.ciclos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CicloData {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  CicloData(
      {this.id, this.name, this.description, this.createdAt, this.updatedAt});

  CicloData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
