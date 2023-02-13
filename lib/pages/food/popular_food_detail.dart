import "package:flutter/material.dart";
import 'package:food_app/controllers/cart_controler.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;

  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
          )),
          //Icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                  //aligment za razdvajanje
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.to(()=>MainFoodPage());
                    },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>CartPage());
                            },
                            child: AppIcon(icon: Icons.shopping_cart_outlined,)),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:0,
                          top:0,
                          child: AppIcon(icon: Icons.circle,
                            size: 20, iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,),
                        ):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:4,
                          top:3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12, color: Colors.white,),
                        ):
                        Container()
                      ],
                    );
                  })
                ],

          )),
          //Intredaction
          Positioned(
            left: 0,
              right: 0,
              top: Dimensions.popularFoodImgSize-20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20)),
                color: Colors.white
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name ,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Itreduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(
                      child: ExpandableText(text: product.description,),
                    ))
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20 ),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2)
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, right: Dimensions.width20, left: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap:(){
                          popularProduct.setQantity(false);
                        },
                      child: Icon(Icons.remove, color: AppColors.signColor,)),
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: popularProduct.inCartItems.toString()),
                  SizedBox(width: Dimensions.width10/2,),
                  GestureDetector(
                      onTap: (){
                        popularProduct.setQantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor,))
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
               popularProduct.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, right: Dimensions.width20, left: Dimensions.width20),
                child: BigText(text: "\$ ${product.price!}" +"Add to chart", color: Colors.white,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                ),
              ),
            )
          ],
        ),
      );
      })
    );
  }
}
