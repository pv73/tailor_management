import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tailor/modal/UserModel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  UserCubit() : super(UserInitialState());

  void addUserModel(UserModel userModel) async {
    emit(UserLoadingState());
    try {
      await _fireStore
          .collection("clients")
          .doc(userModel.uid)
          .set(userModel.toMap());
      emit(UserLoadedState(userModel));
    } catch (e) {
      emit(UserErrorState('Failed to add user: $e'));
    }
  }

  void getUserModel() async {
    emit(UserLoadingState());

    try {
      // Fetch all documents from the 'users' collection
      QuerySnapshot querySnapshot =
          await _fireStore.collection('clients').get();

      // Convert the documents to a list of UserModel objects
      List<UserModel> userList = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      emit(UserLoadedState(userList as UserModel));
    } catch (e) {
      emit(UserErrorState('Failed to get users: $e'));
    }
  }

  void updateUserModel(UserModel updatedUserModel) async {
    emit(UserLoadingState());

    try {
      await _fireStore
          .collection('clients')
          .doc(updatedUserModel.uid)
          .update(updatedUserModel.toMap());

      emit(UserLoadedState(updatedUserModel));
    } catch (e) {
      emit(UserErrorState('Failed to update user: $e'));
    }
  }

  void deleteUserModel(String uid) async {
    emit(UserLoadingState());

    try {
      await _fireStore.collection('clients').doc(uid).delete();
      emit(UserInitialState()); // User deleted, return to initial state
    } catch (e) {
      emit(UserErrorState('Failed to delete user: $e'));
    }
  }
}
