import 'package:doctor_patient/constants/route_names.dart';
import 'package:doctor_patient/ui/views/add_appointment_view.dart';
import 'package:doctor_patient/ui/views/patient_view.dart';
import 'package:doctor_patient/ui/views/doctor_view.dart';
import 'package:doctor_patient/ui/views/home_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case PatientViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PatientView(),
      );
    case DoctorViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DoctorView(),
      );
    case AddAppointmentViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddAppointmentView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
