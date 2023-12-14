import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/aadhar_into_screen.dart';
import 'package:tailor/Screen/navigation_screen/navigation_bar.dart';
import 'package:tailor/Screen/splash/splash_screen.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;
  bool? final_submit;
  String? UserId;

  @override
  void initState() {
    super.initState();
    _getFinalSubmit();
  }

  /// get final Submit true or false
  void _getFinalSubmit() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      final_submit = prefs.getBool('final_submit');
      UserId = prefs.getString('UserId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tailor Management',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocBuilder<AuthCubit, AuthState>(
              // buildWhen worked one time when state is AuthInitialState
              buildWhen: (oldState, newState) {
                return oldState is AuthInitialState;
              },
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  //
                  if (final_submit == true) {
                    return Navigation_Bar();
                  } else {
                    return Aadhar_Card_Screen();
                  }
                  //
                } else if (state is AuthLoggedOutState) {
                  return Splash_Screen();
                } else {
                  return Splash_Screen();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
