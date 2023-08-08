class UserModel {
  String userId;
  String? name;
  String? email;
  String role;
  String? phone;
  double? lat;
  double? lon;
  String? picture;

  int? userCreationTime;

  UserModel(
      {required this.userId,
      this.name,
      this.email,
      this.role = 'User',
      this.phone,
      this.lat,
      this.lon,
      this.picture,
      this.userCreationTime});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'lat': lat,
      'lon': lon,
      'picture': picture,
      'userCreationTime': userCreationTime,
    };
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map['userId'],
        name: map['name'],
        email: map['email'],
        role: map['role'],
        phone: map['phone'],
        picture: map['picture'],
        lat: map['lat'],
        lon: map['lon'],
        userCreationTime: map['userCreationTime'],
      );
}
