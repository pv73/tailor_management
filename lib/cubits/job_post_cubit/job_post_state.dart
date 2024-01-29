part of 'job_post_cubit.dart';

@immutable
abstract class JobPostState {}

class JobPostInitialState extends JobPostState {}

class JobPostLoadingState extends JobPostState {}

class JobPostLoadedState extends JobPostState {
  final JobPostModel jobPostModel;

  JobPostLoadedState(this.jobPostModel);
}

class JobPostErrorState extends JobPostState {
  final String error;

  JobPostErrorState(this.error);
}
