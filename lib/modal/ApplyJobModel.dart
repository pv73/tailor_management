class ApplyJobModel {
  DateTime? dateTime;
  String? userId;
  String? jobId;
  String? user_name;
  bool? isApplied;
  List<String>? garment_category;
  List<String>? skills;

  ApplyJobModel({
    this.dateTime,
    this.userId,
    this.jobId,
    this.user_name,
    this.isApplied,
    this.garment_category,
    this.skills,
  });

  ApplyJobModel.fromMap(Map<String, dynamic> map) {
    dateTime = map['dateTime'];
    userId = map['userId'];
    jobId = map['jobId'];
    user_name = map['user_name'];
    isApplied = map['isApplied'];
    garment_category = List<String>.from(map['garment_category'] ?? []);
    skills = List<String>.from(map['skills'] ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime' : dateTime,
      'userId' : userId,
      'jobId' : jobId,
      'user_name': user_name,
      'isApplied' : isApplied,
      'garment_category': garment_category,
      'skills': skills,
    };
  }
}
