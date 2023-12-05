import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';

String? _verificationId;
String? UserId;
User? currentUser;

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitialState()) {
    // hear checked user already logged In or not
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      // Logged In
      emit(AuthLoggedInState(currentUser!));
    } else {
      // Logged Out
      emit(AuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserId = userCredential.user!.uid;

      emit(AuthLoggedInState(userCredential.user!));

      _fireStore.collection('clients').doc(userCredential.user!.uid).update({
        "uid": userCredential.user!.uid.toString(),
        "phone": userCredential.user!.phoneNumber.toString(),
      });

      // Save UserId to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserId', UserId!);
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
