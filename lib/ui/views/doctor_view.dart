import 'package:doctor_patient/models/appointment_model.dart';
import 'package:doctor_patient/viewmodels/doctor_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:doctor_patient/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class DoctorView extends StatelessWidget {
    final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DoctorViewModel>.withConsumer(
      viewModel: DoctorViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Doctor View'),
        ),
        body: Center(
          child: FutureBuilder<List<Appointment>>(
            future: model.getDoctorAppointments("RASHIDSYL1"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var count = snapshot.data.length;
                return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    var result = snapshot.data[index];
                    return buildColumn(result, index+1, model);
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("You have no appointments!"));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          // AppButton(
          //   buttonText: 'Go to Home Screen',
          //   bgColor: Colors.green,
          //   textColor: Colors.white,
          //   onPressed: () => model.selectDate(context),
          //   // model.showModalSheet(context),
          // ),
        ),
      ),
    );
  }


 Widget buildColumn(Appointment result, int index, DoctorViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Patient " + index.toString(),
          style: textStyle,
        ),
        Text(
          model.getFormattedDate(result.dateTime),
          style: textStyle,
        ),
        Text(
          model.getStatus(result.status),
          style: textStyle,
        ),
        Divider()
      ],
    );
  }
}
