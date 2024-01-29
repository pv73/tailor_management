import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Admin_Dashboard.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Factory_details.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/aadhar_into_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/navigation_bar.dart';
import 'package:tailor/Screen/splash/splash_screen.dart';
import 'package:tailor/Screen/user_onboard/First_Dashboard.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/cubits/company_cubit/company_cubit.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/firebase_options.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/UserModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

// Already Logged In
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? final_submit;
  bool? is_Company;
  bool? company_final_submit;
  User? currentUser;
  UserModel? thisUserModel;
  CompanyModel? thisCompanyModel;

  @override
  void initState() {
    super.initState();
    _getFinalSubmit();
    getUserModel();
  }

  getUserModel() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // LoggedIn
      thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);

      // get company data
      thisCompanyModel =
          await FirebaseHelper.getCompanyModelById(currentUser!.uid);
    }
  }

  /// get final Submit true or false
  void _getFinalSubmit() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      final_submit = prefs.getBool('final_submit');
      is_Company = prefs.getBool('is_Company');
      company_final_submit = prefs.getBool('company_final_submit');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
            BlocProvider<UserCubit>(create: (context) => UserCubit()),
            BlocProvider<CompanyCubit>(create: (context) => CompanyCubit()),
            BlocProvider<JobPostCubit>(create: (context) => JobPostCubit()),
          ],

          // I use GetMaterial because in install get package for page animation
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tailor Management',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (oldState, newState) {
                return oldState is AuthInitialState;
              },
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  // Check hear is Company OR Tailor(Users)

                  if (is_Company == true) {
                    if (company_final_submit == true) {
                      return Admin_Dashboard(
                        firebaseUser: currentUser!,
                        companyModel: thisCompanyModel!,
                      );
                    } else {
                      return Factory_Details(
                        firebaseUser: currentUser!,
                        companyModel: thisCompanyModel!,
                      );
                    }
                  } else {
                    if (final_submit == true) {
                      return Navigation_Bar(
                        firebaseUser: currentUser!,
                        userModel: thisUserModel!,
                      );
                    } else {
                      return Aadhar_Card_Screen(
                        firebaseUser: currentUser!,
                        userModel: thisUserModel!,
                      );
                    }
                  }
                } else if (state is AuthLoggedOutState) {
                  return First_Dashboard();
                }
                return Splash_Screen();
              },
            ),
          ),
        );
      },
    );
  }
}
