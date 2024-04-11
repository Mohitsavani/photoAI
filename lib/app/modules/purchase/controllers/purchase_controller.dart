import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseController extends GetxController {
  //TODO: Implement PurchaseController

  var selectedPlane = 0.obs;
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

  privacy() async {
    final Uri url = Uri.parse('https://www.google.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  term() async {
    final Uri url = Uri.parse('https://www.google.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
