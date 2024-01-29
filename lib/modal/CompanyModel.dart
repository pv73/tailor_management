class CompanyModel {
  String? uid;
  bool? is_company;
  String? user_name;
  String? email;
  String? phone;
  String? company_logo;
  String? company_name;
  String? company_number;
  String? gst_no;
  String? gst_file;
  String? gst_fileName;
  String? pan_no;
  String? address;
  bool? final_submit;

  CompanyModel({
    this.uid,
    this.is_company,
    this.user_name,
    this.email,
    this.phone,
    this.company_logo,
    this.company_name,
    this.company_number,
    this.gst_no,
    this.gst_file,
    this.gst_fileName,
    this.pan_no,
    this.address,
    this.final_submit,
  });

  CompanyModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    is_company = map['is_company'];
    user_name = map['user_name'];
    email = map['email'];
    phone = map['phone'];
    company_logo = map['company_logo'];
    company_name = map['company_name'];
    company_number = map['company_number'];
    gst_no = map['gst_no'];
    gst_file = map['gst_file'];
    gst_fileName = map['gst_fileName'];
    pan_no = map['pan_no'];
    address = map['address'];
    final_submit = map['final_submit'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'is_company': is_company,
      'user_name': user_name,
      'email': email,
      'phone': phone,
      'company_logo': company_logo,
      'company_name': company_name,
      'company_number': company_number,
      'gst_no': gst_no,
      'gst_file': gst_file,
      'gst_fileName': gst_fileName,
      'pan_no': pan_no,
      'address': address,
      'final_submit': final_submit,
    };
  }
}
