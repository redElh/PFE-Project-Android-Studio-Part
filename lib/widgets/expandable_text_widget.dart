import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight=Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();

    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,size: Dimensions.font16
      ,color: Color(0xFFa9a29f),):Column(
        children: [
          SmallText(height:1.8,color:Color(0xFFa9a29f),text: hiddenText?firstHalf+"...":firstHalf+secondHalf,
          size: Dimensions.font16,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(size:14,text: hiddenText?"Show more":"Show less",
                    color: Color(0xFF89dad0)),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,
                    color: Color(0xFF89dad0))
              ],
            ),
          )
        ],
      ),
    );
  }
}
