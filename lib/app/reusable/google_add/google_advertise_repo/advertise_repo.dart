import 'package:flutter/material.dart';

import 'advertise_repo_impl.dart';

class GoogleAdd {
  static GoogleAddRepoImpl getInstance() {
    return GoogleAddRepoImpl();
  }
}

abstract class GoogleAddRepo {
  void loadSmallNative();

  void loadLargeNative();

  Widget showNative({bool isSmall = false});

  Widget googleBannerAdd();

  Future<void> googleOpenAppAdd();

  Future<void> googleOpenAppAddWithOutLoad();

  void loadGoogleInterstitialAdd();

  void showGoogleInterstitialAdd({required void Function() callBack});
}
