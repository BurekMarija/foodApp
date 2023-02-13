import 'package:flutter/material.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("height is"+ MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          //header aplikacije
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row( //Prvi red aplikacije
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column( //Ljevi dio prvog reda
                    children: [
                      BigText(text: "Croatia", color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: "Samobor", color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )

                    ],
                  ),
                  Center(
                    child: Container(//Onaj serch u prvom redu desno
                      width: Dimensions.height45,
                      height:Dimensions.height45,
                      child: Icon(Icons.search, color: Colors.white, size:Dimensions.iconSize24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //body aplikacije
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      )
    );

  }
}
