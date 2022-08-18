import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'data/auth_provider.dart';
import 'data/firestore_provider.dart';
import 'firebase_options.dart';
import 'router/router.dart';
import 'splash/spalsh_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      EasyLocalization(
        supportedLocales: [Locale('ar'), Locale('en')],
        path: 'assets/languages',
        fallbackLocale: Locale('en'),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>(create: (context)=> AuthProvider()),
              ChangeNotifierProvider<FireStoreProvider>(create: (context)=> FireStoreProvider()),
            ],
            child: E_Commerce_Admin()
        ),
      )
  );
}

class E_Commerce_Admin extends StatefulWidget {
  const E_Commerce_Admin({Key? key}) : super(key: key);

  @override
  State<E_Commerce_Admin> createState() => _E_Commerce_AdminState();
}

class _E_Commerce_AdminState extends State<E_Commerce_Admin> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AuthProvider(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: AppRouter.navKey,
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}