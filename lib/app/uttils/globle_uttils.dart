import 'package:flutter/material.dart';

import '../reusable/google_add/google_advertise_repo/advertise_repo.dart';

void appPrint(dynamic str) {
  debugPrint("print value: $str");
}

showInter({required void Function() callBack}) {
  GoogleAdd.getInstance().showGoogleInterstitialAdd(callBack: callBack);
}
