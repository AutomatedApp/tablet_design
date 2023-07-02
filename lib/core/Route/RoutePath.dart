import 'package:flutter/cupertino.dart';
import 'package:tablet_design/home_page.dart';
import 'package:tablet_design/login_screen/login_screen.dart';
import 'package:tablet_design/splash_screen/splash_screen.dart';
import 'package:tablet_design/Record%20Page/Record_page.dart';
import 'package:tablet_design/Record%20Page/start.dart';

Map<String,WidgetBuilder> routes={
  SplshScreen.ROUTE:(c)=>SplshScreen(),
  HomePage.ROUTE:(c)=>HomePage(),
  HomePage.ROUTE:(c)=>HomePage(),
  LoginScreen.ROUTE:(c)=>LoginScreen(),
  record.ROUTE:(c)=>record(),
  record_page.ROUTE:(c)=> record_page(),
};