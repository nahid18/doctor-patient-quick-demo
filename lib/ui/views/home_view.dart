import 'package:provider_architecture/provider_architecture.dart';
import 'package:doctor_patient/viewmodels/home_view_model.dart';
import 'package:doctor_patient/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppButton(
                buttonText: 'Login as a Patient',
                bgColor: Colors.green,
                textColor: Colors.white,
                onPressed: model.navigateToPatientView,
              ),
              SizedBox(
                height: 20.0,
              ),
              AppButton(
                buttonText: 'Login as a Doctor',
                bgColor: Colors.white,
                textColor: Colors.green,
                onPressed: model.navigateToDoctorView,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
