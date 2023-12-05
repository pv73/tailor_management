class UserData {
  String? uid;
  String? phone;
  String? language;
  String? aadhaarNo;
  String? uploadId;
  String? user_name;
  String? email;
  DateTime? dob;
  String? gender;
  String? location;
  String? education;
  String? course;
  String? passing_year;
  List<String>? interest;
  List<String>? category;
  List<String>? personal_skills;
  String? profile_pic;
  String? bank_name;
  String? account_No;
  String? ifsc_code;

  UserData({
    this.uid,
    this.phone,
    this.language,
    this.aadhaarNo,
    this.uploadId,
    this.user_name,
    this.email,
    this.dob,
    this.gender,
    this.location,
    this.education,
    this.course,
    this.passing_year,
    this.interest,
    this.category,
    this.personal_skills,
    this.profile_pic,
    this.bank_name,
    this.account_No,
    this.ifsc_code,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      phone: map['phone'],
      language: map['language'],
      aadhaarNo: map['aadhaarNo'],
      uploadId: map['uploadId'],
      user_name: map['user_name'],
      email: map['email'],
      dob: map['dob'],
      gender: map['gender'],
      location: map['location'],
      education: map['education'],
      course: map['course'],
      passing_year: map['passing_year'],
      interest: List<String>.from(map['interest'] ?? []),
      category: List<String>.from(map['category'] ?? []),
      personal_skills: List<String>.from(map['personal_skills'] ?? []),
      profile_pic: map['profile_pic'],
      bank_name: map['bank_name'],
      account_No: map['account_No'],
      ifsc_code: map['ifsc_code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'language': language,
      'aadhaarNo': aadhaarNo,
      'uploadId': uploadId,
      'user_name': user_name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'location': location,
      'education': education,
      'course': course,
      'passing_year': passing_year,
      'interest': interest,
      'category': category,
      'personal_skills': personal_skills,
      'profile_pic': profile_pic,
      'bank_name': bank_name,
      'account_No': account_No,
      'ifsc_code': ifsc_code,
    };
  }
}
