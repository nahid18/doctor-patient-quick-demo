import 'package:doctor_patient/ui/widgets/input_dropdown.dart';
import 'package:doctor_patient/viewmodels/add_appointment_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:doctor_patient/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AddAppointmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AddAppointmentViewModel>.withConsumer(
      viewModel: AddAppointmentViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Select Doctor'),
                  value: model.selectedDoctor,
                  items: model.dropdownMenuItems,
                  onChanged: (val) => model.setDoctor(val),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InputDropdown(
                  labelText: 'Select Date',
                  valueText: model.getFormattedValue,
                  valueStyle: model.valueStyle,
                  onPressed: () => model.selectDate(context),
                ),
                SizedBox(
                  height: 100.0,
                ),
                AppButton(
                  buttonText: 'Save New Appointment',
                  bgColor: Colors.green,
                  textColor: Colors.white,
                  onPressed: () => model.saveNewAppointment(),
                ),
                SizedBox(height: 20.0),
                AppButton(
                  buttonText: 'Cancel',
                  onPressed: () => model.cancelOperation(),
                  bgColor: Colors.white,
                  textColor: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
