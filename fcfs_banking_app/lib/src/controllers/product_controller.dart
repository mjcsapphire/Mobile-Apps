import 'package:get/get.dart';

class ProductController extends GetxController {
  var selectedProducts = <Map<String, dynamic>>[].obs;
  var totalAmount = 0.0.obs;

  void addProduct(Map<String, dynamic> product) {
    int index =
        selectedProducts.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      selectedProducts[index]['quantity']++;
    } else {
      selectedProducts.add({...product, 'quantity': 1});
    }
    updateTotal();
  }

  void removeProduct(Map<String, dynamic> product) {
    int index =
        selectedProducts.indexWhere((item) => item['name'] == product['name']);
    if (index != -1 && selectedProducts[index]['quantity'] > 0) {
      selectedProducts[index]['quantity']--;
      if (selectedProducts[index]['quantity'] == 0) {
        selectedProducts.removeAt(index);
      }
    }
    updateTotal();
  }

  void updateTotal() {
    totalAmount.value = selectedProducts.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}
