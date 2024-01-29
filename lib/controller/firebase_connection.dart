import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/JobModel.dart';
import 'package:tailor/modal/UserModel.dart';

FirebaseFirestore _firebase = FirebaseFirestore.instance;

class FirebaseHelper {
  /// Tailor(Users) Model get by Id
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;

    DocumentSnapshot docSnap =
        await _firebase.collection("clients").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  /// Company Model get by Id
  static Future<CompanyModel?> getCompanyModelById(String uid) async {
    CompanyModel? companyModel;

    DocumentSnapshot docSnap =
        await _firebase.collection("company").doc(uid).get();

    if (docSnap.data() != null) {
      companyModel =
          CompanyModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return companyModel;
  }

  /// JobPost Model get by Id
  static Future<JobPostModel?> getJobPostModelById(String uid) async {
    JobPostModel? jobPostModel;

    DocumentSnapshot docSnap =
        await _firebase.collection("jobs").doc(uid).get();

    if (docSnap.data() != null) {
      jobPostModel =
          JobPostModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return jobPostModel;
  }
}

/// Get banners
class FirebaseProvider {
  Stream<QuerySnapshot<Map<String, dynamic>>> getBanner() {
    var banner = _firebase.collection("banner");
    return banner.snapshots();
  }

  // get all Data from jobs collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getJobs(uid) {
    var jobs = _firebase
        .collection("jobs")
        .orderBy('dateTime', descending: true)
        .where('uid', isEqualTo: uid);
    return jobs.snapshots();
  }
}
