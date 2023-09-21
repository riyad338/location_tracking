class DropDownModel {
  String pId;
  String? name;

  DropDownModel({
    required this.pId,
    this.name,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'pId': pId,
      'name': name,
    };
    return map;
  }

  factory DropDownModel.fromMap(Map<String, dynamic> map) => DropDownModel(
        pId: map['pId'],
        name: map['name'],
      );
}
