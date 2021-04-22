import 'package:covid19/ui/constant.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'dart:math';

class BoxesReport extends StatefulWidget {
  final Widget TitleName;
  final Widget Total;



  const BoxesReport({this.TitleName, this.Total});
  @override
  _BoxesReportState createState() => _BoxesReportState();
}

class _BoxesReportState extends State<BoxesReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(1,1),
              blurRadius: 5,
              color:Colors.black38,
            )
          ],
        image:  DecorationImage(
          image: AssetImage(
              'assets/coronapic/backbox.png'),
          fit: BoxFit.fill,
        ),
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.TitleName,
          ),
          SizedBox(height: 15,),
          widget.Total
        ],
      ),
    );
  }
}
