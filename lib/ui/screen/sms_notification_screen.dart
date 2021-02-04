import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification.dart';
import 'package:enstaller/core/model/sms_notification_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/sms_notification_view_model.dart';
import 'package:enstaller/ui/screen/view_email_screen.dart';
import 'package:enstaller/ui/screen/widget/emailnotification/email_notification_data_row.dart';
import 'package:enstaller/ui/screen/widget/smsnotification/sms_notification_datarow.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:html/parser.dart';

class SmsNotification extends StatefulWidget {
  @override
  _SmsNotificationState createState() => _SmsNotificationState();
}

class _SmsNotificationState extends State<SmsNotification> {
  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.green);
    return SafeArea(
        child: BaseView<SMSNotificationViewModel>(
      onModelReady: (model) {
        model.getSMSNotification();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
          key: _scaffoldKey,
          drawer: Drawer(
            child: AppDrawerWidget(),
          ),
          appBar: AppBar(
              backgroundColor: AppColors.green,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      ImageFile.menuIcon,
                      color: AppColors.whiteColor,
                    )),
              ),
              title: model.searchBool
                  ? TextField(
                      decoration:
                          InputDecoration(hintText: AppStrings.searchHere),
                      onChanged: (val) {
                        model.onSearch(val);
                      },
                    )
                  : Text(
                      AppStrings.SMS_NOTIFICATION,
                      style: getTextStyle(
                          color: AppColors.whiteColor, isBold: false),
                    ),
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      model.searchBool ? Icons.clear : Icons.search,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    model.onClickSerach();
                  },
                ),
                SizeConfig.horizontalSpaceSmall(),
              ]),
          body: model.state == ViewState.Busy
              ? AppConstants.circulerProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () => Future.delayed(Duration.zero)
                      .whenComplete(() => model.getSMSNotification()),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: (model.smsList.isNotEmpty == true)
                          ? Padding(
                              padding: SizeConfig.padding,
                              child: ListView.builder(
                                itemCount: model.smsList.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: SizeConfig.verticalC13Padding,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors
                                              .appointmentBackGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          _emailHistroyInfo(model.smsList[i]),
//                                Divider(
//                                  color: AppColors.darkGrayColor,
//                                  thickness: 1.0,
//                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(child: Text(AppStrings.noDataFound))),
                ),
        );
      },
    ));
  }

  Widget _emailHistroyInfo(SmsNotificationModel sms) {
    return Column(
      children: [
        SMSNotificationDataRow(
          firstText: AppStrings.date,
          secondText: AppConstants.formattedSingeDate(
                  DateTime.parse(sms?.dteCreatedDate)) ??
              "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.bookingrefno,
          secondText: sms?.strBookingReference.toString() ?? "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.customer,
          secondText: sms?.customerName ?? "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.sendTo,
          secondText: sms?.msgto ?? "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.page,
          secondText: sms?.strPageName ?? "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.sms,
          secondText: sms?.body ?? "",
        ),
        SMSNotificationDataRow(
          firstText: AppStrings.status,
          secondText: sms?.msgStatus ?? "",
        ),
      ],
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}
