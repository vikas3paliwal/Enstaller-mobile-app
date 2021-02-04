import 'dart:convert';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/model/activity_details_model.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/customer_details.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
import 'package:enstaller/core/model/email_notification.dart';
import 'package:enstaller/core/model/login_credentials.dart';
import 'package:enstaller/core/model/login_responsemodel.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/sms_notification_model.dart';
import 'package:enstaller/core/model/update_status_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/base_api.dart';
import 'package:enstaller/core/model/survey_response_model.dart';

class ApiService extends BaseApi {
  Future<dynamic> loginWithUserNamePassword(LoginCredential loginCredential) {
    return postRequest(ApiUrls.logInUrl, (r) {
      final responseError = json.decode(r.body)['error_description'];
      if (responseError != null) {
        return LoginResponseModel(errorMessage: responseError);
      } else {
        return LoginResponseModel(
            errorMessage: null,
            userDetails: UserModel.fromJson(json.decode(r.body)));
      }
    }, loginCredential.toJson());
  }

  Future<dynamic> getAppointmentList(String userID) {
    return getRequestWithParam(ApiUrls.getAppointMentListUrl, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => Appointment.fromJson(e))
          .toList();
    }, 'id=$userID');
  }

  Future<dynamic> getActivityLogsAppointmentId(String appointmentID) {
    return getRequestWithParam(ApiUrls.getActivityLogsAppointmentIdUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => ActivityDetailsModel.fromJson(e))
          .toList();
    }, 'intId=$appointmentID');
  }

  Future<dynamic> getAppointmentDetails(String appointmentID) {
    return getRequest(ApiUrls.getAppointmentDetailsUrl, (response) {
      print(response.body);
      return AppointmentDetails.fromJson(json.decode(response.body));
    }, '/$appointmentID');
  }

  Future<dynamic> getAppointmentCommentsByAppointment(String appointmentID) {
    return getRequestWithParam(ApiUrls.getAppointmentCommentsByAppointmentUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }, 'intappintmentid=$appointmentID');
  }

  Future<dynamic> getCustomerMeterListByCustomer(String customerID) {
    return getRequestWithParam(ApiUrls.getCustomerMeterListByCustomerUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => ElectricAndGasMeterModel.fromJson(e))
          .toList();
    }, 'intCustomerId=$customerID');
  }

  Future<dynamic> submitComment(CommentCredential commentCredential) {
    return postRequest(ApiUrls.saveAppointmentComments, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Submited');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, commentCredential.toJson());
  }

  Future<dynamic> appointmentDataEventsbyEngineer(String engineerID) {
    return getRequestWithParam(ApiUrls.appointmentDataEventsbyEngineerUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => StatusModel.fromJson(e))
          .toList();
    }, 'intId=$engineerID');
  }

  Future<dynamic> updateAppointmentStatus(
      AppointmentStatusUpdateCredentials credentials) {
    print(credentials.toJson());
    return postRequest(ApiUrls.updateAppointmentStatusUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(statusCode: 1, response: 'Successfully Updated');
      } else {
        return ResponseModel(statusCode: 0, response: 'Please try again');
      }
    }, credentials.toJson());
  }

  Future<dynamic> getSurveyQuestionAppointmentWise(String appointmentID) {
    return getRequestWithParam(ApiUrls.getSurveyQuestionAppointmentWiseUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => SurveyResponseModel.fromJson(e))
          .toList();
    }, 'intappointmentId=$appointmentID');
  }

  Future<dynamic> getSurveyQuestionAnswerDetail(String appointmentID) {
    return getRequestWithParam(ApiUrls.getSurveyQuestionAnswerDetailUrl,
        (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => QuestionAnswer.fromJson(e))
          .toList();
    }, 'intappointmentId=$appointmentID');
  }

  Future<dynamic> submitSurveyAnswer(AnswerCredential credentials) {
    return postRequest(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(statusCode: 1, response: 'Successfully Updated');
    }, credentials.toJson());
  }

  Future<dynamic> submitListSurveyAnswer(List<AnswerCredential> credentials) {
    return postRequestList(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(statusCode: 1, response: 'Successfully Updated');
    }, json.encoder.convert(credentials));
  }

  Future<dynamic> getCustomerById(String customerID) {
    return getRequestWithParam(ApiUrls.getCustomerByIdUrl, (response) {
      print(response.body);
      return CustomerDetails.fromJson(json.decode(response.body));
    }, 'intCustomerId=$customerID');
  }

  Future<dynamic> getEngineerAppointments(String engeenerID, String date) {
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl, (response) {
      print(response.body);
      return (json.decode(response.body)['table'] as List)
          .map((e) => AppTable.fromJson(e))
          .toList();
    }, 'today=$date' + '&intId=$engeenerID');
  }

  Future<dynamic> getTodaysAppointments(String engeenerID, String date) {
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl, (response) {
      print(response.body);
      return (json.decode(response.body)['table'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList();
    }, 'today=$date' + '&intId=$engeenerID');
  }

  Future<dynamic> getEmailHistoryUserVise(String intUserId) {
    return getRequestWithParam(ApiUrls.emailNotificationUrl, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => EmailNotificationModel.fromJson(e))
          .toList();
    }, 'intUserId=' + '$intUserId');
  }

  Future<dynamic> getSMSClickSendNotification(String intUserId) {
    return getRequestWithParam(ApiUrls.smsNotificationUrl, (response) {
      print(response.body);
      return (json.decode(response.body) as List)
          .map((e) => SmsNotificationModel.fromJson(e))
          .toList();
    }, 'intUserId=' + '$intUserId');
  }
}
