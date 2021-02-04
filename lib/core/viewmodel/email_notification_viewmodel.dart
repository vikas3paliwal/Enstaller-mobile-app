import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class EmailNotificationViewModel extends BaseModel {
  List<EmailNotificationModel> emailList = [];
  List<EmailNotificationModel> _emailList = [];
  bool searchBool = false;
  ApiService _apiService = ApiService();

  void getEmailNotificationHistory() async {
    setState(ViewState.Busy);
    UserModel userModel = await Prefs.getUser();
    _emailList = await _apiService.getEmailHistoryUserVise('20030');

    emailList = _emailList;
    setState(ViewState.Idle);
  }

  void onClickSerach() {
    setState(ViewState.Busy);
    searchBool = !searchBool;
    if (!searchBool) {
      emailList = _emailList;
    }
    setState(ViewState.Idle);
  }

  void onSearch(String val) {
    setState(ViewState.Busy);
    emailList = [];
    _emailList.forEach((element) {
      if (element.customerName.toLowerCase().contains(val.toLowerCase()) ||
          element.strAttachmentPath.toLowerCase().contains(val.toLowerCase()) ||
          element.engineerName.toLowerCase().contains(val.toLowerCase()) ||
          element.strEmail.toLowerCase().contains(val.toLowerCase()) ||
          element.supplierCompany.toLowerCase().contains(val.toLowerCase()) ||
          element.strActionby.toLowerCase().contains(val.toLowerCase())) {
        emailList.add(element);
      }
    });
    setState(ViewState.Idle);
  }
}
