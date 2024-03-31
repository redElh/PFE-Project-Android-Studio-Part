import 'package:first_project/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatefulWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({
    Key? key,
    this.color=const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  _BigTextState createState() => _BigTextState();
}

class _BigTextState extends State<BigText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: 1,
      overflow: widget.overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: widget.color,
        fontWeight: FontWeight.w400,
        fontSize: widget.size==0?Dimensions.font20:widget.size,
      ),
    );
  }
}