import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablet_design/core/Route/RoutePath.dart';
import 'package:tablet_design/core/firebase_options.dart';
import 'package:tablet_design/core/local/app_local.dart';
import 'package:tablet_design/core/utils/app_them.dart';
import 'package:tablet_design/core/utils/constant.dart';
import 'package:tablet_design/core/network/local_network.dart';
import 'splash_screen/splash_screen.dart';
import 'package:tablet_design/core/local/local_controller.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await cashNetwork.cashInitialization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocaleController controller=Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale:controller.initialLang,
      theme: appthem(),
      translations: MyLocale(),
      initialRoute: SplshScreen.ROUTE,
      routes: routes,
    );
  }
}