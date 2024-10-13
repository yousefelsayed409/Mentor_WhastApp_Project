import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorwhatsapp/core/function/change_state_auth.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/SignIn_Cubit/cubit/sign_in_cubit.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/SignUp_Cubit/signup_cubit.dart';
import 'package:mentorwhatsapp/core/routes/app_route.dart';
import 'package:mentorwhatsapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ChangeStateAuth();
  runApp(const MentorWhatsApp());
}

class MentorWhatsApp extends StatelessWidget {
  const MentorWhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoute.splashView,
            onGenerateRoute: AppRoute.generateRoute,
          );
        },
      ),
    );
  }
}
