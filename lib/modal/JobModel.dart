
class JobPostModel {
  DateTime? dateTime;
  String? uid;
  String? jobId;
  String? company_logo;
  String? garment_type;
  String? company_name;
  String? garment_order_qty;
  String? tailor_department;
  String? job_type;
  String? total_employee;
  String? tailor_category;
  String? categorySalary;
  String? stitching_price;
  String? minimun_Salary;
  String? maxmimum_Salary;
  String? address;
  String? state;
  String? garment_image;
  String? part_rate_image;
  String? worked_type;
  String? worked_shift;
  String? minimum_experience;
  String? maxmimum_experience;
  String? job_responsibilities;
  String? interview_mode;
  String? interviewAddress;
  String? workLocation;
  String? job_description;
  List<String>? tailor_skill;
  List<String>? tailor_education;

  JobPostModel({
    this.dateTime,
    this.uid,
    this.jobId,
    this.company_logo,
    this.garment_type,
    this.company_name,
    this.garment_order_qty,
    this.tailor_department,
    this.job_type,
    this.tailor_skill,
    this.total_employee,
    this.tailor_category,
    this.categorySalary,
    this.stitching_price,
    this.minimun_Salary,
    this.maxmimum_Salary,
    this.address,
    this.state,
    this.garment_image,
    this.part_rate_image,
    this.worked_type,
    this.worked_shift,
    this.minimum_experience,
    this.maxmimum_experience,
    this.job_responsibilities,
    this.tailor_education,
    this.interview_mode,
    this.interviewAddress,
    this.workLocation,
    this.job_description,
  });

  JobPostModel.fromMap(Map<String, dynamic> map) {
    dateTime = map['dateTime'];
    uid = map['uid'];
    jobId = map['jobId'];
    company_logo = map['company_logo'];
    garment_type = map['garment_type'];
    company_name = map['company_name'];
    garment_order_qty = map['garment_order_qty'];
    tailor_department = map['tailor_department'];
    job_type = map['job_type'];
    tailor_skill = (map['tailor_skill']);
    total_employee = map['total_employee'];
    tailor_category = map['tailor_category'];
    categorySalary = map['categorySalary'];
    stitching_price = map['stitching_price'];
    minimun_Salary = map['minimun_Salary'];
    maxmimum_Salary = map['maxmimum_Salary'];
    address = map['address'];
    state = map['state'];
    garment_image = map['garment_image'];
    part_rate_image = map['part_rate_image'];
    worked_type = map['worked_type'];
    worked_shift = map['worked_shift'];
    minimum_experience = map['minimum_experience'];
    maxmimum_experience = map['maxmimum_experience'];
    job_responsibilities = map['job_responsibilities'];
    tailor_education = (map['tailor_education']);
    interview_mode = map['interview_mode'];
    interviewAddress = map['interviewAddress'];
    workLocation = map['workLocation'];
    job_description = map['job_description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'uid': uid,
      'jobId': jobId,
      'company_logo': company_logo,
      'garment_type': garment_type,
      'company_name': company_name,
      'garment_order_qty': garment_order_qty,
      'tailor_department': tailor_department,
      'job_type': job_type,
      'tailor_skill': tailor_skill,
      'total_employee': total_employee,
      'tailor_category': tailor_category,
      'categorySalary': categorySalary,
      'stitching_price': stitching_price,
      'minimun_Salary': minimun_Salary,
      'maxmimum_Salary': maxmimum_Salary,
      'address': address,
      'state': state,
      'garment_image': garment_image,
      'part_rate_image': part_rate_image,
      'worked_type': worked_type,
      'worked_shift': worked_shift,
      'minimum_experience': minimum_experience,
      'maxmimum_experience': maxmimum_experience,
      'job_responsibilities': job_responsibilities,
      'tailor_education': tailor_education,
      'interview_mode': interview_mode,
      'interviewAddress': interviewAddress,
      'workLocation': workLocation,
      'job_description': job_description,
    };
  }
}
