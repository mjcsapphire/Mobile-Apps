import 'package:dio/dio.dart';
import 'package:fcfs_banking_app/services/api/currency_api_service.dart';
import 'package:fcfs_banking_app/src/models/currency_model.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  final Dio dio;
  var currencyResponse = Rx<CurrencyResponse?>(null);
  late CurrencyApiService currencyApiService = CurrencyApiService(dio);
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  CurrencyController(this.dio);

  // Function to fetch currency data
  Future<void> fetchCurrency() async {
    isLoading.value = true;
    errorMessage.value = '';
    // Make the API call
    final result = await currencyApiService.getCurrency();
    result.fold(
      (failure) {
        errorMessage.value = failure.toString();
        isLoading.value = false;
      },
      (response) {
        currencyResponse(response);
        isLoading.value = false;
      },
    );
  }

  double getExchangeRate(String currencyCode) {
    final currency = currencyResponse.value?.data[currencyCode];
    return currency?.value ?? 0.0;
  }
}
