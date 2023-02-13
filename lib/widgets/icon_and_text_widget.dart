import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final iconColour;
  const IconAndTextWidget({Key? key,
  required this.icon,
  required this.text,
  required this.iconColour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColour, size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
