class Ciclos {
  List<CiclosData>? ciclos;

  Ciclos({this.ciclos});

  Ciclos.fromJson(Map<String, dynamic> json) {
    if (json['Ciclos'] != null) {
      ciclos = <CiclosData>[];
      json['Ciclos'].forEach((v) {
        ciclos!.add(CiclosData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (ciclos != null) {
      data['Ciclos'] = this.ciclos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CiclosData {
  int? id;
  String? name;
  String? description;
  int? profileId;
  String? createdAt;
  String? updatedAt;

  CiclosData(
      {this.id,
      this.name,
      this.description,
      this.profileId,
      this.createdAt,
      this.updatedAt});

  CiclosData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    profileId = json['profile_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['profile_id'] = this.profileId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
