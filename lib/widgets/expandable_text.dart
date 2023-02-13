import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_text.dart';

import '../utils/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;

  double textHeight=Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      //razdvojimo na prvi dio do visine polja, i drugi dio je ostatak
      firstHalf=widget.text.substring(0, textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf=""; //proglasili smo varijablu "late" pa moramo staviti nešto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? //dali je tekst kratak
      SmallText(height: 1.8, color:AppColors.pargColor, size: Dimensions.font16, text: firstHalf): //ako da, samo prvi dio
      Column(
        children: [
          SmallText(height: 1.8, color:AppColors.pargColor ,size: Dimensions.font16, text: hiddenText?(firstHalf+ "..."):(firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
              
            },
            child: Row(
              children: [
                SmallText( text: "Show more", color: AppColors.mainColor,),
                Icon(hiddenText? Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
