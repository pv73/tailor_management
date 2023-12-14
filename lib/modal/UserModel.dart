class UserModel {
  String? uid;
  String? phone;
  String? language;
  String? aadhaar_no;
  String? document;
  String? user_name;
  String? email;
  DateTime? dob;
  bool? final_submit;
  String? gender;
  String? address;
  String? education;
  String? course;
  String? education_year;
  String? category;
  List<String>? interest;
  List<String>? skills;
  String? profile_pic;
  String? bank_name;
  String? account_number;
  String? ifsc_code;
  String? experience_company;
  String? collage_name;

  UserModel(
      {this.uid,
      this.phone,
      this.language,
      this.aadhaar_no,
      this.document,
      this.user_name,
      this.email,
      this.dob,
      this.gender,
      this.address,
      this.education,
      this.course,
      this.education_year,
      this.interest,
      this.category,
      this.skills,
      this.profile_pic,
      this.bank_name,
      this.account_number,
      this.ifsc_code,
      this.collage_name,
      this.final_submit,
      this.experience_company});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    phone = map['phone'];
    language = map['language'];
    aadhaar_no = map['aadhaar_no'];
    document = map['document'];
    user_name = map['user_name'];
    email = map['email'];
    dob = map['dob'];
    gender = map['gender'];
    address = map['address'];
    education = map['education'];
    course = map['course'];
    education_year = map['education_year'];
    category = map['category'];
    interest = List<String>.from(map['interest'] ?? []);
    skills = List<String>.from(map['skills'] ?? []);
    profile_pic = map['profile_pic'];
    bank_name = map['bank_name'];
    account_number = map['account_number'];
    ifsc_code = map['ifsc_code'];
    collage_name = map['collage_name'];
    final_submit = map['final_submit'];
    experience_company = map['experience_company'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'language': language,
      'aadhaar_no': aadhaar_no,
      'document': document,
      'user_name': user_name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'address': address,
      'education': education,
      'course': course,
      'passing_year': education_year,
      'interest': interest,
      'category': category,
      'skills': skills,
      'profile_pic': profile_pic,
      'bank_name': bank_name,
      'account_number': account_number,
      'ifsc_code': ifsc_code,
      'collage_name': collage_name,
      'final_submit': final_submit,
      'experience_company': experience_company,
    };
  }
}
