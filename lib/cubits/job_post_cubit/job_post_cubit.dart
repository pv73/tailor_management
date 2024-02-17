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

  //======== Add New Job===============
  void addJobPostModel(JobPostModel jobPostModel) async {
    emit(JobPostLoadingState());
    try {
      await _fireStore.collection("jobs").doc(jobPostModel.jobId).set(jobPostModel.toMap());
      emit(JobPostLoadedState(jobPostModel));
    } catch (e) {
      emit(JobPostErrorState('Failed to add user: $e'));
    }
  }

  // ============= Get all data using jobId ==================
  Future<Map<String, dynamic>> getAllDataByJobId(String jobId) async {
    DocumentSnapshot jobIdSnapshot = await _fireStore.collection('jobs').doc(jobId).get();

    return jobIdSnapshot.data() as Map<String, dynamic>;
  }

  //=============== Stream to listen and show Descending Order ==================
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataFilterByOrder() {
    var jobs = _fireStore.collection("jobs").orderBy('dateTime', descending: true);

    return jobs.snapshots();
  }

  //======================= Update Job Post model by id ======================
  void updateJobPostModel(JobPostModel updateJobPostModel) async {
    emit(JobPostLoadingState());

    try {
      await _fireStore.collection('jobs').doc(updateJobPostModel.jobId).update(updateJobPostModel.toMap());

      emit(JobPostLoadedState(updateJobPostModel));
    } catch (e) {
      emit(JobPostErrorState('Failed to update user: $e'));
    }
  }

  //======================= Delete Job Post model by id ======================
  void deleteJobPostModel(String jobId) async {
    emit(JobPostLoadingState());

    try {
      await _fireStore.collection('jobs').doc(jobId).delete();
      emit(JobPostInitialState()); // User deleted, return to initial state
    } catch (e) {
      emit(JobPostErrorState('Failed to delete user: $e'));
    }
  }
}
