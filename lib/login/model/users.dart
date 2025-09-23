class Users {
  final int? usrId;
  final String fullname;
  final String email;
  final String usrName;
  final String password;

  Users({
    this.usrId,
    required this.fullname,
    required this.email,
    required this.usrName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'usrId': usrId,
      'fullname': fullname,
      'email': email,
      'usrName': usrName,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      usrId: map['usrId'],
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      usrName: map['usrName'] ?? '',
      password: map['password'] ?? '',
    );
  }

  get fullName => null;
}
