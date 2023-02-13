import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controler.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/popular_product.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController{
  //jedan zove drugoga, ko friking babuške. Controler zove repository a on zove client
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=> _popularProductList;
  late CartController _cart;

  bool _isLoading=false;
  bool get isLoaded=>_isLoading;

  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async{
    Response response= await popularProductRepo.getPopularProductList();
    if(response.status.code==200){//uspješan
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);

      _isLoading=true;
      update(); //kao set state
    }else{
      print("nije");
      print(response.status.code);

    }
  }

  void setQantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
    }else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can´t reduce more",
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems<0){
        _quantity=_inCartItems;
        return quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Item count", "You can´t add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    //get from storage _inCartItems
    if(exist){
      _inCartItems=_cart.getQuantiti(product);
    }
  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantiti(product);
      _cart.items.forEach((key, value) {
      });

    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List <CartModel> get getItems{
    return _cart.getItems;
  }
}