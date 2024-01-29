part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitialState extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanyLoadedState extends CompanyState {
  final CompanyModel companyModel;

  CompanyLoadedState(this.companyModel);
}

class CompanyErrorState extends CompanyState {
  final String error;

  CompanyErrorState(this.error);
}
