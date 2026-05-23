class UserProfileModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;

  UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserProfileModel(
      uid: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
