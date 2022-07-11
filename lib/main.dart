import 'package:flutter/material.dart';
import 'package:history_feature/providers/Notifications.dart';
import 'package:history_feature/models/GlobalTheme.dart';
import 'package:history_feature/providers/auth.dart';
import 'package:history_feature/providers/jobs.dart';
import 'package:history_feature/screens/add_test.dart';
import 'package:history_feature/screens/notification_page.dart';
import 'package:history_feature/screens/settings_page.dart';
import 'package:history_feature/screens/applicant_register_screen.dart';
import 'package:history_feature/screens/job_operations_screen.dart';
import 'package:history_feature/screens/job_view.dart';
import 'package:history_feature/screens/Register_Screen.dart';
import 'package:history_feature/screens/recruiter_register_screen.dart';
import 'package:history_feature/screens/splash_screen.dart';
import 'package:history_feature/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:history_feature/screens/Login_Screen.dart';
import 'package:history_feature/models/GlobalTheme.dart';
import 'package:history_feature/screens/ForgetPassword_Screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GlobalTheme()),
    ChangeNotifierProvider(create: (_) => Auth()),
    ChangeNotifierProvider(create: (_) => Jobs(), ),
    ChangeNotifierProvider(create: (_) => Notifications()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    final ThemeData globalTheme = Provider.of<GlobalTheme>(context).globalTheme;
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Int-Hire',
          theme: globalTheme,
          home: SplashScreen
            (
            SplashTheme: globalTheme,
          )
          ,
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(loginTheme: globalTheme,),
            SplashScreen.routeName: (ctx) => SplashScreen(SplashTheme: globalTheme,),
            RegisterScreen.routeName: (ctx) => RegisterScreen(registerTheme: globalTheme,),
            JobView.routeName: (ctx) => JobView(jobTheme: globalTheme,),
            add_test.routeName: (ctx) => add_test(),
            JobOperations.routeName: (ctx) => JobOperations(),
            HistoryHomePage.routeName: (ctx) => HistoryHomePage(historyTheme: globalTheme,),
            Settings_page.routeName: (ctx)=>Settings_page(settingsTheme: globalTheme,),
            Notification_page.routeName:(ctx)=>Notification_page(notificationTheme: globalTheme,),
            ForgotPassword.routeName:(ctx)=>ForgotPassword(registerTheme: globalTheme),
          //  ForgotPassword.id: (context) => ForgotPassword(),
            applicant_register_screen.routeName: (ctx) => applicant_register_screen(registerTheme: globalTheme,),
            recruiter_register_screen.routeName: (ctx) => recruiter_register_screen(registerTheme: globalTheme,),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
          },
        ),
    );
  }
}
