import 'package:doctor_patient/models/appointment_model.dart';
import 'package:doctor_patient/models/doctor_model.dart';
import 'package:doctor_patient/services/database_service.dart';
import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/constants/route_names.dart';
import 'package:doctor_patient/viewmodels/base_model.dart';
import 'package:doctor_patient/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAppointmentViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // String _selectedDoctor = getDoctors

  TextStyle _valueStyle = TextStyle(color: Colors.black);

  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;

  void setDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void setTime(TimeOfDay newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }





  List<Doctor> _doctors = Doctor.getDoctors();
  List<Doctor> get doctors => _doctors;

  List<DropdownMenuItem<String>> _buildDropdownMenuItems(List doctors) {
    List<DropdownMenuItem<String>> items = List();
    for (Doctor doc in doctors) {
      items.add(
        DropdownMenuItem(
          value: doc.doctorId,
          child: Text(doc.doctorName),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> get dropdownMenuItems => _buildDropdownMenuItems(_doctors);

  String _selectedDoctor;
  String get selectedDoctor => _selectedDoctor;

  void setDoctor(String doctorId) {
    _selectedDoctor = doctorId;
    notifyListeners();
  }

  void cancelOperation() {
    _navigationService.pop();
  }


  void printData() {
    String _patientId = "AAN2020";
    int dateTime = _selectedDate.millisecondsSinceEpoch;
    int status = 0;
    String doctorId = _selectedDoctor;
    // String doctorId = _selectedDoctor / "RASHIDSYL1";

    print(_patientId);
    print(dateTime);
    print(status);
    print(doctorId);   
  }



  

  String get getFormattedValue => DateFormat('yMMMMd').format(_selectedDate);
  TextStyle get valueStyle => _valueStyle;


  Future saveNewAppointment() async {
    return await _databaseService.insertNewAppointment(_selectedDate.microsecondsSinceEpoch, _selectedDoctor.toString()).then((value) {
      print(_selectedDate.microsecondsSinceEpoch);
      print(_selectedDoctor);
      _navigationService.pop();
    });
  }


  Future selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 12, 1, 1, 1),
      lastDate: DateTime(2050, 12, 30, 11, 59),
    );
    if (picked != null && picked != selectedDate) setDate(picked);

    var utc = selectedDate.microsecondsSinceEpoch;
    print(selectedDate);
    print(utc);
    print(DateTime.fromMicrosecondsSinceEpoch(utc));
  }

  Future selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedTime) setTime(picked);
    print(selectedTime);
  }







}
