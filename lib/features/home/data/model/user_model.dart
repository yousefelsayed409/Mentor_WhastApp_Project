class UserModel {
  final String uid;
  final String name;
  final String pfpURL;

  UserModel({required this.uid, required this.name, required this.pfpURL});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'] ?? '',
      name: json['name'] ?? '',
      pfpURL: json.containsKey('profilePic') ? json['profilePic'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'profilePic': pfpURL,
    };
  }
}
