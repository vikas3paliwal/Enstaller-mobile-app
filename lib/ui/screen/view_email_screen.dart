import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class ViewEmailArguments {
  final String content;
  ViewEmailArguments({this.content});
}

class ViewEmailScreen extends StatefulWidget {
  static const routeName = '/view_email_screen';
  final ViewEmailArguments emailArguments;
  ViewEmailScreen({this.emailArguments});
  @override
  _ViewEmailScreenState createState() => _ViewEmailScreenState();
}

class _ViewEmailScreenState extends State<ViewEmailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scafoldColor,
        key: _scaffoldKey,
        // drawer: Drawer(
        //   child: AppDrawerWidget(),
        // ),
        appBar: AppBar(
          backgroundColor: AppColors.green,
          centerTitle: true,
          title: Text(
            AppStrings.EMAIL_NOTIFICATION,
            style: getTextStyle(color: AppColors.whiteColor, isBold: false),
          ),
        ),
        body: Padding(
          padding: SizeConfig.mediumCPadding,
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            padding: SizeConfig.smallpadding,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.green, width: 2),
              color: AppColors.whiteColor,
            ),
            child: SingleChildScrollView(
              child: Text(
                widget.emailArguments.content,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
  return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      fontSize: fontSize);
}
