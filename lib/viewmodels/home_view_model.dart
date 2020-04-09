import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/viewmodels/base_model.dart';
import 'package:doctor_patient/constants/route_names.dart';
import 'package:doctor_patient/locator.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToPatientView() {
    _navigationService.navigateTo(PatientViewRoute);
  }

  void navigateToDoctorView() {
    _navigationService.navigateTo(DoctorViewRoute);
  }
}