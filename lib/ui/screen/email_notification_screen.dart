import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/email_notification_viewmodel.dart';
import 'package:enstaller/ui/screen/view_email_screen.dart';
import 'package:enstaller/ui/screen/widget/emailnotification/email_notification_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:html/parser.dart';

class EmailNotification extends StatefulWidget {
  @override
  _EmailNotificationState createState() => _EmailNotificationState();
}

class _EmailNotificationState extends State<EmailNotification> {
  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.green);
    return SafeArea(
        child: BaseView<EmailNotificationViewModel>(
      onModelReady: (model) {
        model.getEmailNotificationHistory();
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
                      AppStrings.EMAIL_NOTIFICATION,
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
                      .whenComplete(() => model.getEmailNotificationHistory()),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: (model.emailList.isNotEmpty == true)
                          ? Padding(
                              padding: SizeConfig.padding,
                              child: ListView.builder(
                                itemCount: model.emailList.length,
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
                                          _emailHistroyInfo(model.emailList[i]),
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

  Widget _emailHistroyInfo(EmailNotificationModel email) {
    return Column(
      children: [
        EmailNotificationDataRow(
          firstText: AppStrings.date,
          secondText: AppConstants.formattedSingeDate(
                  DateTime.parse(email?.dteCreatedDate)) ??
              "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.appoinmentNumber,
          secondText: email?.intAppointmentId.toString() ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.email,
          secondText: email?.strEmail ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.customer,
          secondText: email?.customerName ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.page,
          secondText: email?.strPageName ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.supplier,
          secondText: email?.supplierCompany ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.engineer,
          secondText: email?.engineerName ?? "",
        ),
        EmailNotificationDataRow(
          firstText: AppStrings.actionBy,
          secondText: email?.strActionby ?? "",
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          child: AppButton(
            buttonText: AppStrings.view,
            color: AppColors.green,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              final emailData = email.strMailContent;
              final emaitContent = HtmlParser(emailData)
                  .parse()
                  .body
                  .text
                  .trimRight()
                  .trim()
                  .replaceAll('  ', '');

              Navigator.of(context).pushNamed(ViewEmailScreen.routeName,
                  arguments: ViewEmailArguments(content: emaitContent));
            },
          ),
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
