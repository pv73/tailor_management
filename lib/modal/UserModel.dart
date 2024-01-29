class UserModel {
  String? uid;
  String? phone;
  String? aadhaar_no;
  String? front_document;
  String? back_document;
  String? user_name;
  String? line_leader_name;
  String? group_no;
  String? tailor_type;
  String? totalExpYears;
  String? totalExpMonths;
  String? email;
  String? dob;
  bool? final_submit;
  String? gender;
  String? permanent_address;
  String? address;
  String? education;
  String? course;
  String? passing_year;
  List<String>? garment_category;
  List<String>? category;
  List<String>? interest;
  List<String>? skills;
  List<String>? language;
  String? profile_pic;
  String? bank_name;
  String? account_number;
  String? ifsc_code;
  String? experience_company;
  String? collage_name;
  bool? bank_request;
  bool? is_company;

  UserModel({
    this.uid,
    this.phone,
    this.language,
    this.aadhaar_no,
    this.front_document,
    this.back_document,
    this.user_name,
    this.line_leader_name,
    this.group_no,
    this.tailor_type,
    this.totalExpYears,
    this.totalExpMonths,
    this.email,
    this.dob,
    this.gender,
    this.permanent_address,
    this.address,
    this.education,
    this.course,
    this.passing_year,
    this.interest,
    this.garment_category,
    this.category,
    this.skills,
    this.profile_pic,
    this.bank_name,
    this.account_number,
    this.ifsc_code,
    this.collage_name,
    this.final_submit,
    this.experience_company,
    this.bank_request,
    this.is_company,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    phone = map['phone'];
    aadhaar_no = map['aadhaar_no'];
    front_document = map['front_document'];
    back_document = map['back_document'];
    user_name = map['user_name'];
    line_leader_name = map['line_leader_name'];
    group_no = map['group_no'];
    tailor_type = map['tailor_type'];
    totalExpYears = map['totalExpYears'];
    totalExpMonths = map['totalExpMonths'];
    email = map['email'];
    dob = map['dob'];
    gender = map['gender'];
    permanent_address = map['permanent_address'];
    address = map['address'];
    education = map['education'];
    course = map['course'];
    passing_year = map['passing_year'];
    garment_category = List<String>.from(map['garment_category'] ?? []);
    category = List<String>.from(map['category'] ?? []);
    interest = List<String>.from(map['interest'] ?? []);
    skills = List<String>.from(map['skills'] ?? []);
    language = List<String>.from(map['language'] ?? []);
    profile_pic = map['profile_pic'];
    bank_name = map['bank_name'];
    account_number = map['account_number'];
    ifsc_code = map['ifsc_code'];
    collage_name = map['collage_name'];
    final_submit = map['final_submit'];
    experience_company = map['experience_company'];
    bank_request = map['bank_request'];
    is_company = map['is_company'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'language': language,
      'aadhaar_no': aadhaar_no,
      'front_document': front_document,
      'back_document': back_document,
      'user_name': user_name,
      'line_leader_name': line_leader_name,
      'group_no': group_no,
      'tailor_type': tailor_type,
      'totalExpYears': totalExpYears,
      'totalExpMonths': totalExpMonths,
      'email': email,
      'dob': dob,
      'gender': gender,
      'permanent_address': permanent_address,
      'address': address,
      'education': education,
      'course': course,
      'passing_year': passing_year,
      'interest': interest,
      'garment_category': garment_category,
      'category': category,
      'skills': skills,
      'profile_pic': profile_pic,
      'bank_name': bank_name,
      'account_number': account_number,
      'ifsc_code': ifsc_code,
      'collage_name': collage_name,
      'final_submit': final_submit,
      'experience_company': experience_company,
      'bank_request': bank_request,
      'is_company': is_company,
    };
  }
}
