import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/popular_product.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=> _recommendedProductList;

  bool _isLoading=false;
  bool get isLoaded=>_isLoading;

  Future<void> getRecommendedProductList() async{
    Response response= await recommendedProductRepo.getRecommendedProductList();
    if(response.status.code==200){//uspješan
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoading=true;
      update(); //kao set state
    }else{
      print(response.status.code);

    }
  }
}