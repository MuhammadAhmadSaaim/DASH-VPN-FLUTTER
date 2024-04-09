import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';

import 'helpers/pref.dart';

//Global object to store screen size
late Size mq;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Pref.initializeHive();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then(
          (v){
            runApp(const MyApp());
      },);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true,elevation: 3)
      ),
      title: 'DASH',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
