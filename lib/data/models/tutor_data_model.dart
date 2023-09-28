class TutorDataModel {
  String id;
  String name;
  String avatarUrl;
  int permission;

  TutorDataModel(this.id, this.name, this.avatarUrl, this.permission);

  factory TutorDataModel.fromJson(dynamic json) {
    return TutorDataModel(
      json['id'] as String,
      json['name'] as String,
      json['avatarUrl'] as String,
      json['permission'] as int,
    );
  }
}
