part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitialState extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanyLoadedState extends CompanyState {
  final CompanyModel? companyModel;
  final int? companyDocsLength;

  CompanyLoadedState(this.companyModel, this.companyDocsLength);
}

class CompanyErrorState extends CompanyState {
  final String error;

  CompanyErrorState(this.error);
}
