import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/navigation_service.dart';
import 'package:enstaller/core/viewmodel/appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/email_notification_viewmodel.dart';
import 'package:enstaller/core/viewmodel/get_user_details_viewmodel.dart';
import 'package:enstaller/core/viewmodel/home_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/login_viewmodel.dart';
import 'package:enstaller/core/viewmodel/show_appointmentbydate_viewmodel.dart';
import 'package:enstaller/core/viewmodel/sms_notification_view_model.dart';
import 'package:enstaller/core/viewmodel/survey_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/today_appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/update_status_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  //UI Models
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());

  //screenViewModel

  getIt.registerFactory(() => LogInViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => DetailsScreenViewModel());
  getIt.registerFactory(() => CommentDialogViewModel());
  getIt.registerFactory(() => UpdateStatusViewModel());
  getIt.registerFactory(() => SurveyScreenViewModel());
  getIt.registerFactory(() => AppointmentViewModel());
  getIt.registerFactory(() => TodayAppointmentViewModel());
  getIt.registerFactory(() => ShowAppointmentByDateViewmodel());
  getIt.registerFactory(() => GetUserDetailsViewModel());
  getIt.registerFactory(() => EmailNotificationViewModel());
  getIt.registerFactory(() => SMSNotificationViewModel());
}
