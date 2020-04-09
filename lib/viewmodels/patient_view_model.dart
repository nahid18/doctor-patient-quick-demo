import 'package:doctor_patient/services/database_service.dart';
import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/models/appointment_model.dart';
import 'package:doctor_patient/ui/widgets/bottom_sheet.dart';
import 'package:doctor_patient/viewmodels/base_model.dart';
import 'package:doctor_patient/constants/route_names.dart';
import 'package:doctor_patient/models/doctor_model.dart';
import 'package:doctor_patient/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  void addNewAppointment() {
    _navigationService.navigateTo(AddAppointmentViewRoute);
  }

  String getFormattedDate(int value) {
    return DateFormat('yMMMMd').format(DateTime.fromMicrosecondsSinceEpoch(value));
  }

  String getStatus(int value) {
    if (value !=0) {
      return 'Done'; 
    } else return 'Pending';
  }

  void showModalSheet(BuildContext context) {
    showModalBottomSheetApp(
      context: context,
      builder: (builder) {
        return buildSheetLogin(context);
      },
    );
  }

  Widget buildSheetLogin(context) {
    return Container();
  }

  Future<List<Appointment>> getPendingAppointments(String patientId) async {
    List<Map> data = await _databaseService.getPatientAppointments(patientId);
    List<Appointment> appoints = List();
    print(data);
    for (int i = 0; i< data.length; i++) {
      appoints.add(
        Appointment(
          patientId: data[i]['patient_id'], 
          dateTime: data[i]['date_time'], 
          doctorId: data[i]['doctor_id'], 
          status: data[i]['status'],
          doctor: Doctor(
            doctorName: data[i]['doc_name'],            
            doctorLocation: data[i]['doc_location'],
          )
        )
      );
    }
    print(appoints[0]);
    return appoints;
  }

  Future deleteData() async {
    await _databaseService.deleteData();
  }

  Future removeData(int value) async {
    await _databaseService.removeData(value);
  }
}
