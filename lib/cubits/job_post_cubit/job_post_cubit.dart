import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tailor/modal/JobModel.dart';
part 'job_post_state.dart';


class JobPostCubit extends Cubit<JobPostState> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  JobPostCubit() : super(JobPostInitialState());

  // all Data store in clients_data list from clients collection firebase
  final jobPosts = [];

  // Add New Job
  void addJobPostModel(JobPostModel jobPostModel) async {
    emit(JobPostLoadingState());
    try {
      await _fireStore.collection("jobs").doc().set(jobPostModel.toMap());
      emit(JobPostLoadedState(jobPostModel));
    } catch (e) {
      emit(JobPostErrorState('Failed to add user: $e'));
    }
  }

  // Stream to listen and get all docs
  Future<QuerySnapshot<Map<String, dynamic>>> getAllData() {
    var jobs = _fireStore.collection("jobs").get();

    return jobs;
  }

  // Stream to listen and show Descending Order
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataFilterByOrder() {
    var jobs =
    _fireStore.collection("jobs").orderBy('dateTime', descending: true);

    return jobs.snapshots();
  }

  // Update Job Post model by id
  void updateJobPostModel(JobPostModel updateJobPostModel) async {
    emit(JobPostLoadingState());

    try {
      await _fireStore
          .collection('company')
          .doc(updateJobPostModel.uid)
          .update(updateJobPostModel.toMap());

      emit(JobPostLoadedState(updateJobPostModel));
    } catch (e) {
      emit(JobPostErrorState('Failed to update user: $e'));
    }
  }

  void deleteCompanyModel(String uid) async {
    emit(JobPostLoadingState());

    try {
      await _fireStore.collection('company').doc(uid).delete();
      emit(JobPostInitialState()); // User deleted, return to initial state
    } catch (e) {
      emit(JobPostErrorState('Failed to delete user: $e'));
    }
  }
}
