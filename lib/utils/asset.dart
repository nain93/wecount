import 'package:flutter/material.dart';
import 'package:wecount/types/color.dart';

class Icons {
  Icons._();
  static AssetImage icMask = AssetImage('res/icons/icMask.png');
  static AssetImage icWeCount = AssetImage('res/icons/wecount.png');
  static AssetImage icFacebook = AssetImage('res/icons/icFacebook.png');
  static AssetImage icGoogle = AssetImage('res/icons/icGoogle.png');
  static AssetImage icTab1 = AssetImage('res/icons/icTab1.png');
  static AssetImage icTab2 = AssetImage('res/icons/icTab2.png');
  static AssetImage icTab3 = AssetImage('res/icons/icTab3.png');
  static AssetImage icTab4 = AssetImage('res/icons/icTab4.png');
  static AssetImage icRed = AssetImage('res/icons/icRed.png');
  static AssetImage icOrange = AssetImage('res/icons/icOrange.png');
  static AssetImage icYellow = AssetImage('res/icons/icYellow.png');
  static AssetImage icGreen = AssetImage('res/icons/icGreen.png');
  static AssetImage icBlue = AssetImage('res/icons/icBlue.png');
  static AssetImage icDusk = AssetImage('res/icons/icDusk.png');
  static AssetImage icPurple = AssetImage('res/icons/icPurple.png');
  static AssetImage tutorial1 = AssetImage('res/icons/tutorial1.png');
  static AssetImage tutorial2 = AssetImage('res/icons/tutorial2.png');
  static AssetImage tutorial3 = AssetImage('res/icons/tutorial3.png');
  static AssetImage noLedger = AssetImage('res/icons/noLedger.png');
  static AssetImage icCoins = AssetImage('res/icons/icCoins.png');
  static AssetImage icOwner = AssetImage('res/icons/picOwner.png');
}

class Images {
  Images._();
}

class Colors {
  Colors._();
  static const light = Color(0xffffffff);
  static const lightDim = Color.fromARGB(255, 250, 250, 250);
  static const dark = Color(0xff111111);
  static const darkDim = Color.fromARGB(255, 0, 0, 0);
  static const pink = Color(0xffa750b9);
  static const greenBlue = Color(0xff24cd97);
  static const paleGray = Color(0xffdde2ec);
  static const mediumGray = Color(0xff869ab7);
  static const whiteGray = Color(0xfff9fbfd);
  static const darkishPink = Color(0xffe6677e);
  static const skyBlueBright = Color(0xff00b0ff);
  static const warmGray = Color(0xff979797);
  static const purpleLight = Color(0xffb669f9);
  static const golden = Color(0xffeed100);
  static const squash = Color(0xfff6a623);
  static const carnation = Color(0xffff728d);
  static const cloudyBlue = Color(0xffafc2db);

  static const red = Color.fromARGB(255, 255, 114, 141);
  static const orange = Color.fromARGB(255, 245, 166, 35);
  static const yellow = Color.fromARGB(255, 240, 192, 0);
  static const green = Color.fromARGB(255, 29, 211, 168);
  static const blue = Color.fromARGB(255, 103, 157, 255);
  static const main = Color.fromARGB(255, 13, 178, 147);
  static const purple = Color.fromARGB(255, 182, 105, 249);
  static Color getColor(ColorType? color) {
    return color == ColorType.RED
        ? Colors.red
        : color == ColorType.ORANGE
            ? Colors.orange
            : color == ColorType.YELLOW
                ? Colors.yellow
                : color == ColorType.GREEN
                    ? Colors.green
                    : color == ColorType.BLUE
                        ? Colors.blue
                        : color == ColorType.PURPLE
                            ? Colors.purple
                            : Colors.main;
  }
}
