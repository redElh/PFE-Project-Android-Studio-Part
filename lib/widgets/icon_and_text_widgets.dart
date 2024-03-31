import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidgets extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidgets({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text)
      ],
    );
  }
}
