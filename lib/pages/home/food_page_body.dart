import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_comtroller.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text_widget.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../utils/app_constants.dart';
import '../../widgets/app_column.dart';
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  //controler za pageview
  PageController pageController= PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height= Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=pageController.page!;
      });

    });
  }
  @override
  void dispose(){pageController.dispose();}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded? Container(
            //color:  Colors.red,
            height: Dimensions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }
              ),

          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Slider
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: AppColors.mainColor,
            ),
          );

        }),
        //Popularno
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end ,
            children: [
              BigText(text: "Recomended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 3) ,
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                child: SmallText(text: "Food pairing",),
              ),
            ],
          ),
        ),
        //Recommended food dio
        //Lista
        GetBuilder<RecommendedProductController>(builder: (recommandedProduct){
          return recommandedProduct.isLoaded? Container(
            height: 700,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommandedProduct.recommendedProductList.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //Slike
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit:BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommandedProduct.recommendedProductList[index].img!
                                    )
                                )
                            ),
                          ),
                          //Tekst
                          Expanded( //zauzima ostatak slobodnog mjesta
                            child: Container(
                              height: Dimensions.pageViewTextContainer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20),
                                    bottomRight: Radius.circular(Dimensions.radius20)
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommandedProduct.recommendedProductList[index].name),
                                    SizedBox(height: Dimensions.height10,),
                                    SmallText(text: "With chinese characteristics"),
                                    SizedBox(height: Dimensions.height10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.circle_sharp,
                                            text: "Normal",
                                            iconColour: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.location_on,
                                            text: "1.7km",
                                            iconColour: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.access_time_rounded,
                                            text: "32 min",
                                            iconColour: AppColors.iconColor2)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, popularProduct){
    //Pun kufer posla da bi prijelazi bili glatki
    Matrix4 matrix= new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index==_currPageValue.floor()+1){
      var currScale=_scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix =Matrix4.diagonal3Values(1, currScale, 1);
      matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index==_currPageValue.floor()-1){
      var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix =Matrix4.diagonal3Values(1, currScale, 1);
      matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale=0.8;
      matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(//Da ih mogu složiti jedan preko drugoga
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(//Onaj sa slikom
      height: Dimensions.pageViewContainer,
      margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius30),
      color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
      image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
      )
      ),
      ),
      ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(//Onaj sa opisom
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.width30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                child:AppColumn(text: popularProduct.name,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
