import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/views/SignUP_Screen.dart';
import 'package:mentorwhatsapp/features/Auth/forgot_Password/presentation/views/Foregot_Password_View.dart';
// import 'package:mentorwhatsapp/features/auth/presentation/views/login_view.dart';
// import 'package:mentorwhatsapp/features/auth/presentation/views/profile_view.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/home_view.dart';
import 'package:mentorwhatsapp/features/splash/view/splash_view.dart';

class AppRoute {
  static const splashView = 'SplashView';
          static const signInView = 'SignInView';
        static const signUpView = 'SignUpView';
        static const forgetPassword = 'ForgetPasswordView';

  static const loginview = 'LoginView';
    static const profileScreen = 'ProfileScreen';
        static const homeView = 'HomeView';



  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return SizeTransition3(const SplashView());
      // case loginview:
      //   return SizeTransition3(  const LoginView(),);
         case signInView:
        return SizeTransition3(  const SignInview (),);
         case signUpView:
        return SizeTransition3(   SignUPView(),);
         case loginview:
        return SizeTransition3(  const ForgetPasswordView(),);
        //   case profileScreen:
        // return SizeTransition3(  const ProfileScreen(),);
           case homeView:
        return SizeTransition3(   HomeView(),);
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('noRouteFound'),
            ),
          )),
    );
  }
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 4),
          reverseTransitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 2),
          // reverseTransitionDuration:const  Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
