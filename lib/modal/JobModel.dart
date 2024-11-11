class JobPostModel {
  DateTime? dateTime;
  String? uid;
  String? jobId;
  String? company_logo;
  String? company_name;
  String? company_address;
  String? phone;
  String? company_number;
  String? garment_type;
  String? garment_image;
  String? garmentPicName;
  String? garment_order;
  String? work_type;
  String? work_shift;
  String? job_type;
  String? department;
  String? category;
  String? samp_salary;
  String? part_time_category;
  String? part_time_sub_cat;
  String? pt_sub_cat_text;
  String? grade_salary;
  String? grade_salary_amount;
  String? part_rate;
  String? part_rate_text;
  String? part_rate_url;
  String? part_rate_url_name;
  String? full_pc_amount;
  String? full_pc;
  String? total_tailor;
  String? minimum_experience;
  String? maximum_experience;
  List<String>? tailor_skill;
  List<String>? skills_tailor_employee;

  JobPostModel({
    this.dateTime,
    this.uid,
    this.jobId,
    this.company_logo,
    this.company_name,
    this.company_address,
    this.phone,
    this.company_number,
    this.garment_type,
    this.garment_image,
    this.garmentPicName,
    this.garment_order,
    this.work_type,
    this.work_shift,
    this.job_type,
    this.department,
    this.category,
    this.samp_salary,
    this.part_time_category,
    this.part_time_sub_cat,
    this.pt_sub_cat_text,
    this.grade_salary,
    this.grade_salary_amount,
    this.part_rate,
    this.part_rate_text,
    this.part_rate_url,
    this.part_rate_url_name,
    this.full_pc_amount,
    this.full_pc,
    this.total_tailor,
    this.minimum_experience,
    this.maximum_experience,
    this.tailor_skill,
    this.skills_tailor_employee,
  });
  //
  JobPostModel.fromMap(Map<String, dynamic> map) {
    dateTime = map['dateTime'];
    uid = map['uid'];
    jobId = map['jobId'];
    company_logo = map['company_logo'];
    company_name = map['company_name'];
    company_address = map['company_address'];
    phone = map['phone'];
    company_number = map['company_number'];
    garment_type = map['garment_type'];
    garment_image = map['garment_image'];
    garmentPicName = map['garmentPicName'];
    garment_order = map['garment_order'];
    work_type = map['work_type'];
    work_shift = map['work_shift'];
    job_type = map['job_type'];
    department = map['department'];
    category = map['category'];
    samp_salary = map['samp_salary'];
    part_time_category = map['part_time_category'];
    part_time_sub_cat = map['part_time_sub_cat'];
    pt_sub_cat_text = map['pt_sub_cat_text'];
    grade_salary = map['grade_salary'];
    grade_salary_amount = map['grade_salary_amount'];
    part_rate = map['part_rate'];
    part_rate_text = map['part_rate_text'];
    part_rate_url = map['part_rate_url'];
    part_rate_url_name = map['part_rate_url_name'];
    full_pc_amount = map['full_pc_amount'];
    full_pc = map['full_pc'];
    total_tailor = map['total_tailor'];
    minimum_experience = map['minimum_experience'];
    maximum_experience = map['maximum_experience'];
    tailor_skill = map['tailor_skill'];
    skills_tailor_employee = map['skills_tailor_employee'];
  }
  //
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'uid': uid,
      'jobId': jobId,
      'company_logo': company_logo,
      'company_name': company_name,
      'company_address': company_address,
      'phone' : phone,
      'company_number' : company_number,
      'garment_type': garment_type,
      'garment_image': garment_image,
      'garmentPicName': garmentPicName,
      'garment_order': garment_order,
      'work_type': work_type,
      'work_shift': work_shift,
      'job_type': job_type,
      'department': department,
      'category': category,
      'samp_salary': samp_salary,
      'part_time_category': part_time_category,
      'part_time_sub_cat': part_time_sub_cat,
      'pt_sub_cat_text': pt_sub_cat_text,
      'grade_salary': grade_salary,
      'grade_salary_amount': grade_salary_amount,
      'part_rate': part_rate,
      'part_rate_text': part_rate_text,
      'part_rate_url': part_rate_url,
      'part_rate_url_name': part_rate_url_name,
      'full_pc_amount': full_pc_amount,
      'full_pc': full_pc,
      'total_tailor': total_tailor,
      'minimum_experience': minimum_experience,
      'maximum_experience': maximum_experience,
      'tailor_skill': tailor_skill,
      'skills_tailor_employee': skills_tailor_employee,
    };
  }
}
