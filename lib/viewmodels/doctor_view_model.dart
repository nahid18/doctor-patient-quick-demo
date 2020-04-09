import 'package:doctor_patient/models/appointment_model.dart';
import 'package:doctor_patient/services/database_service.dart';
import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/constants/route_names.dart';
import 'package:doctor_patient/viewmodels/base_model.dart';
import 'package:doctor_patient/locator.dart';
import 'package:intl/intl.dart';

class DoctorViewModel extends BaseModel {
    final NavigationService _navigationService = locator<NavigationService>();
    final DatabaseService _databaseService = locator<DatabaseService>();

  void navigateToHomeView() {
    _navigationService.pop();
  }

  String getFormattedDate(int value) {
    return DateFormat('yMMMMd').format(DateTime.fromMicrosecondsSinceEpoch(value));
  }

  String getStatus(int value) {
    if (value !=0) {
      return 'Done'; 
    } else return 'Provide Prescription';
  }
  
  Future<List<Appointment>> getDoctorAppointments(String doctorId) async {
    List<Map> data = await _databaseService.getDoctorAppointments(doctorId);
    List<Appointment> appoints = List();
    print(data);
    for (int i = 0; i< data.length; i++) {
      appoints.add(
        Appointment(
          patientId: data[i]['patient_id'], 
          dateTime: data[i]['date_time'], 
          doctorId: data[i]['doctor_id'], 
          status: data[i]['status'],
        )
      );
    }
    print(appoints[0]);
    return appoints;
  }
}