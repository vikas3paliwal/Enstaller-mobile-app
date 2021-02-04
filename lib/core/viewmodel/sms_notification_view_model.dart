import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/sms_notification_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class SMSNotificationViewModel extends BaseModel {
  List<SmsNotificationModel> smsList = [];
  List<SmsNotificationModel> _smsList = [];
  bool searchBool = false;
  ApiService _apiService = ApiService();

  void getSMSNotification() async {
    setState(ViewState.Busy);
    UserModel userModel = await Prefs.getUser();
    _smsList = await _apiService.getSMSClickSendNotification('20030');

    smsList = _smsList;
    setState(ViewState.Idle);
  }

  void onClickSerach() {
    setState(ViewState.Busy);
    searchBool = !searchBool;
    if (!searchBool) {
      smsList = _smsList;
    }
    setState(ViewState.Idle);
  }

  void onSearch(String val) {
    setState(ViewState.Busy);
    smsList = [];
    _smsList.forEach((element) {
      if (element.customerName.toLowerCase().contains(val.toLowerCase()) ||
          element.strBookingReference
              .toLowerCase()
              .contains(val.toLowerCase()) ||
          element.msgto.toLowerCase().contains(val.toLowerCase()) ||
          element.strPageName.toLowerCase().contains(val.toLowerCase()) ||
          element.msgStatus.toLowerCase().contains(val.toLowerCase()) ||
          element.body.toLowerCase().contains(val.toLowerCase())) {
        smsList.add(element);
      }
    });
    setState(ViewState.Idle);
  }
}
