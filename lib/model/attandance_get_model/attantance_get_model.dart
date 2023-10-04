class User {
  final int id;
  final String name;
  final String? profilePicture;
  final String? dateOfBirth;
  final String email;
  final String? gender;
  final String? guardianName;
  final int? guardianContactNumber;
  final int? number;
  final bool? married;
  final int? alternateNumber;
  final bool? isFormFilled;
  final String? lastPayment;
  final bool? isSuperUser;
  final String? address;
  final String? pincode;
  final String? post;
  final int? aadharNumber;
  final int? age;

  User({
    required this.id,
    required this.name,
    this.profilePicture,
    this.dateOfBirth,
    required this.email,
    this.gender,
    this.guardianName,
    this.guardianContactNumber,
    this.number,
    this.married,
    this.alternateNumber,
    this.isFormFilled,
    this.lastPayment,
    this.isSuperUser,
    this.address,
    this.pincode,
    this.post,
    this.aadharNumber,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
      dateOfBirth: json['date_of_birth'],
      email: json['email'],
      gender: json['gender'],
      guardianName: json['guardian_name'],
      guardianContactNumber: json['guardian_contact_number'],
      number: json['number'],
      married: json['married'],
      alternateNumber: json['alternate_number'],
      isFormFilled: json['is_form_filled'],
      lastPayment: json['last_payment'],
      isSuperUser: json['is_superuser'],
      address: json['address'],
      pincode: json['pincode'],
      post: json['post'],
      aadharNumber: json['aadhar_number'],
      age: json['age'],
    );
  }
}

class AttendanceRecord {
  final int id;
  final User user;
  final String date;
  final bool isPresent;

  AttendanceRecord({
    required this.id,
    required this.user,
    required this.date,
    required this.isPresent,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      user: User.fromJson(json['user']),
      date: json['date'],
      isPresent: json['is_present'],
    );
  }
}
