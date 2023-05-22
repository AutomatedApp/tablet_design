import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tablet_design/core/network/local_network.dart';

class MyLocaleController extends GetxController {
  Locale initialLang = cashNetwork.getCashData(key: "curruntLang")=="ar"?Locale("ar"):Locale("en");
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    cashNetwork.insertToCash( key: "curruntLang",value: codeLang);
    Get.updateLocale(locale);
  }
}