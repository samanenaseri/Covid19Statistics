import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig{
  static double _screenwidth;
  static double _screenHeight;
  static double _blockSizeHorizontal=0;
  static double _blockSizeVertical =0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints,Orientation orientation){
    if(orientation == Orientation.portrait){
      _screenwidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if(_screenwidth<450){
        isMobilePortrait = true;
      }
    } else {
      _screenwidth = constraints.maxHeight;
      _screenHeight = constraints.maxHeight;
      isPortrait = false;
      isMobilePortrait = false;
    }
    _blockSizeHorizontal = _screenwidth /100;
    _blockSizeVertical = _screenHeight /100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
    print(_blockSizeHorizontal);
    print(_blockSizeVertical);
  }


}