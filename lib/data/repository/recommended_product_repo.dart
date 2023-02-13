import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_app/data/api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RESOMMENDED_PRODUCT_URI);
  }
}