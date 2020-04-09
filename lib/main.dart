import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/managers/dialog_manager.dart';
import 'package:doctor_patient/services/dialog_service.dart';
import 'package:doctor_patient/ui/router.dart';
import 'package:flutter/material.dart';
import 'ui/views/home_view.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeView(),
      onGenerateRoute: generateRoute,
    );
  }
}
