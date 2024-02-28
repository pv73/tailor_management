import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tailor/modal/CompanyModel.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  CompanyCubit() : super(CompanyInitialState());

  void addCompanyModel(CompanyModel companyModel) async {
    emit(CompanyLoadingState());
    try {
      await _fireStore.collection("company").doc(companyModel.uid).set(companyModel.toMap());
      emit(CompanyLoadedState(companyModel));
    } catch (e) {
      emit(CompanyErrorState('Failed to add user: $e'));
    }
  }

  void getCompanyModel() async {
    emit(CompanyLoadingState());

    try {
      // Fetch all documents from the 'users' collection
      QuerySnapshot querySnapshot = await _fireStore.collection('company').get();

      // Convert the documents to a list of UserModel objects
      List<CompanyModel> companyList =
          querySnapshot.docs.map((doc) => CompanyModel.fromMap(doc.data() as Map<String, dynamic>)).toList();

      emit(CompanyLoadedState(companyList as CompanyModel));
    } catch (e) {
      emit(CompanyErrorState('Failed to get users: $e'));
    }
  }

  void updateCompanyModel(CompanyModel updatedCompanyModel) async {
    emit(CompanyLoadingState());

    try {
      await _fireStore.collection('company').doc(updatedCompanyModel.uid).update(updatedCompanyModel.toMap());

      emit(CompanyLoadedState(updatedCompanyModel));
    } catch (e) {
      emit(CompanyErrorState('Failed to update user: $e'));
    }
  }

  void deleteCompanyModel(String uid) async {
    emit(CompanyLoadingState());

    try {
      await _fireStore.collection('company').doc(uid).delete();
      emit(CompanyInitialState()); // User deleted, return to initial state
    } catch (e) {
      emit(CompanyErrorState('Failed to delete user: $e'));
    }
  }
}
