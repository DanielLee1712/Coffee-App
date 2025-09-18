class Users {
  final int? usrId;
  final String fullname;
  final String email;
  final String usrName;
  final String password;
  final String? avatarPath;

  Users({
    this.usrId,
    required this.fullname,
    required this.email,
    required this.usrName,
    required this.password,
    this.avatarPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'usrId': usrId,
      'fullname': fullname,
      'email': email,
      'usrName': usrName,
      'password': password,
      'avatarPath': avatarPath,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      usrId: map['usrId'],
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      usrName: map['usrName'] ?? '',
      password: map['password'] ?? '',
      avatarPath: map['avatarPath'],
    );
  }
}
