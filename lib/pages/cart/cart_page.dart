import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controler.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../utils/app_constants.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left:Dimensions.width20,
          right: Dimensions.width20,
          top: Dimensions.height20*3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(icon: Icons.arrow_back_ios,
                iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,),
              SizedBox(width: Dimensions.width20*5,),
              GestureDetector(
                onTap: (){
                  Get.to(()=>MainFoodPage());
                },
                child: AppIcon(icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,),
              ),
              AppIcon(icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,),
            ],
          )),
          Positioned(
            top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //color: Colors.red,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index){
                          return Container(
                            height: Dimensions.height20*5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.height20*5,
                                  height: Dimensions.height20*5,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                          )
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                //Container u expanded uzima  sav dostupan prostor
                                Expanded(child: Container(
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    //main po x osi, cross y os
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                      SmallText(text: 'Spicy',),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].price!.toString(), color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, right: Dimensions.width10, left: Dimensions.width10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      //popularProduct.setQantity(false);
                                                    },
                                                    child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                SizedBox(width: Dimensions.width10/2,),
                                                BigText(text:"0" ),//popularProduct.inCartItems.toString()),
                                                SizedBox(width: Dimensions.width10/2,),
                                                GestureDetector(
                                                    onTap: (){
                                                      //popularProduct.setQantity(true);
                                                    },
                                                    child: Icon(Icons.add, color: AppColors.signColor,))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),

                                ))
                              ],
                            ),
                          );

                        });
                  }),
                ),

          ))
        ],
      ),
    );
  }
}
