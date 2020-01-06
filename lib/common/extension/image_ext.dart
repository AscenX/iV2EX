import 'package:flutter/material.dart';


/// 图片资源
extension ImageAssets on Image {

  /// 图片名
  String get name {
    String n = RegExp(r'".+"').stringMatch(this.image.toString());
    return n.length > 2 ? n.substring(1, n.length-1) : "";
  }

  /// 130 x 132
  static Image stan({Color color, BoxFit fit = BoxFit.cover, double width, double height}) =>
 Image.asset("assets/stan.png", color: color, fit: fit, width: width, height: height);

}
/// 图片资源 end