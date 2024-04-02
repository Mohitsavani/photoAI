import 'dart:io' show Platform;

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/assets.dart';
import '../../../core/local_string.dart';
import '../../../reusable/global.dart';

class ProfileController extends GetxController {
  var profileLoaded = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<DrawerItem> drawerItem = [
    DrawerItem(title: LocalString.privacy, icon: AppIcons.privacy),
    DrawerItem(
        title: LocalString.termsAndConditions, icon: AppIcons.termAndCondi),
    DrawerItem(title: LocalString.rateMyApp, icon: AppIcons.rateApp),
    DrawerItem(title: LocalString.share, icon: AppIcons.share),
    DrawerItem(title: LocalString.help, icon: AppIcons.help),
  ];

  privacy() async {
    final Uri url = Uri.parse('http://flyer.psktechnology.com/Policy.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  term() async {
    final Uri url = Uri.parse('http://flyer.psktechnology.com/Terms.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  rate() {
    StoreRedirect.redirect(
      androidAppId: "com.app.posteriya.ai.generator",
    );
  }

  share() {
    if (Platform.isAndroid) {
      Share.share(
          '🎨 Create Stunning Posters Instantly! 🚀 Unleash your '
          'creativity with the Fastiva Poster Maker app. Design eye-catching'
          ' posters effortlessly and share your message in style. Try it now '
          'and let your imagination soar! ✨ #FastivaPosterMaker #DesignMagic '
          'https://play.google.com/store/apps/details?id=poster.maker.festiva.app.festiva_poster',
          subject: 'Look what I made!');
    } else {
      Share.share(
          '🎨 Create Stunning Posters Instantly! 🚀 Unleash your '
          'creativity with the Fastiva Poster Maker app. Design eye-catching'
          ' posters effortlessly and share your message in style. Try it now '
          'and let your imagination soar! ✨ #FastivaPosterMaker #DesignMagic '
          'https://apps.apple.com/us/app/fastiva-poster-&-flyer-maker/id6476674135',
          subject: 'Look what I made!');
    }
  }

  void help() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'greetingsappdev@gmail.com',
    );
    urlLauncher(params);
  }

  Future<void> urlLauncher(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
      );
    }
  }
}
