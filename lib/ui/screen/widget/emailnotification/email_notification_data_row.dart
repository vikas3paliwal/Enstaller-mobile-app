import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class EmailNotificationDataRow extends StatelessWidget {
  final String firstText;
  final String secondText;

  EmailNotificationDataRow({this.firstText, this.secondText});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.lightGrayDotColor))),
      child: Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  firstText,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
                flex: 3,
                child: Text(
                  secondText,
                  style: TextStyle(color: AppColors.darkGrayColor),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}
