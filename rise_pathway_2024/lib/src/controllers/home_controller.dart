import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';

class HomeController extends GetxController {
  final RxInt navIndex = 0.obs;
  final RxBool isPlayerVisible = false.obs;
  final RxInt emojiIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    moods[emojiIndex.value];
  }
}
///[]