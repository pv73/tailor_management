import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/UserModel.dart';

User? currentUser;
UserCredential? credential;
String? _verificationId;

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitialState()) {
    currentUser = _auth.currentUser;

    checkCurrentUser();
  }

  void checkCurrentUser() async {
    try {
      if (currentUser != null) {
        // Logged In
        UserModel? userModel = await FirebaseHelper.getUserModelById(currentUser!.uid);

        CompanyModel? companyModel = await FirebaseHelper.getCompanyModelById(currentUser!.uid);

        if (userModel != null || companyModel != null) {
          emit(AuthLoggedInState(currentUser!));
        } else {
          // Logged Out
          emit(AuthLoggedOutState());
        }
        //
      } else {
        emit(AuthLoggedOutState());
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  /// Tailor (Users) Sign Up function
  void tailorSignUp(String email, String password, UserModel userModel) async {
    emit(AuthLoadingState());

    try {
      credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }

    if (credential != null) {
      String uid = credential!.user!.uid;

      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        user_name: userModel.user_name,
        phone: userModel.phone,
        is_company: userModel.is_company,
      );

      await _fireStore.collection("clients").doc(uid).set(newUser.toMap());
      emit(AuthEmailStoreState());
    }
  }

  /// Company Sign Up function
  void companySignUp(String email, String password, CompanyModel companyModel) async {
    emit(AuthLoadingState());

    try {
      credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }

    if (credential != null) {
      String uid = credential!.user!.uid;
      CompanyModel newCompany = CompanyModel(
        uid: uid,
        email: email,
        user_name: companyModel.user_name,
        phone: companyModel.phone,
        is_company: companyModel.is_company,
      );

      await _fireStore.collection("company").doc(uid).set(newCompany.toMap());
      emit(AuthEmailStoreState());
    }
  }

  void logIn(String email, String password) async {
    emit(AuthLoadingState());
    try {
      credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      emit(AuthLoggedInState(credential!.user!));
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

// TODO : Phone Login bottom 3 Function

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) async {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        print("=========== ${error.message.toString()}");
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
      signInWithPhone(credential);
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    UserCredential? userCredential;

    try {
      userCredential = await _auth.signInWithCredential(credential);

      String? UserId = userCredential.user!.uid;

      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc = await _fireStore.collection('clients').doc(UserId).get();

      if (!userDoc.exists) {
        // User doesn't exist, perform Firebasestore setup
        UserModel newUser = UserModel(
          uid: UserId,
          phone: userCredential.user!.phoneNumber.toString(),
        );
        await _fireStore.collection("clients").doc(UserId).set(newUser.toMap());
      }

      emit(AuthLoggedInState(userCredential.user!));
      //
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
