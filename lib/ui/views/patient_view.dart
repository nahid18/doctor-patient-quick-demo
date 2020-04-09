import 'package:doctor_patient/models/appointment_model.dart';
import 'package:doctor_patient/viewmodels/patient_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
// import 'package:doctor_patient/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class PatientView extends StatelessWidget {
  final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PatientViewModel>.withConsumer(
      viewModel: PatientViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Patient View'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green,
          onPressed: () => model.addNewAppointment(),
        ),
        body: Center(
          child: FutureBuilder<List<Appointment>>(
            future: model.getPendingAppointments("AAN2020"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var count = snapshot.data.length;
                return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    var result = snapshot.data[index];
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        model.removeData(result.dateTime);
                        // snapshot.data.removeAt(index);
                      },
                      secondaryBackground: Container(
                        child: Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      background: Center(child: Text("You have no appointments!")),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      child: buildColumn(result, model),
                    );
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

  Widget buildColumn(Appointment result, PatientViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          result.doctor.doctorName,
          style: textStyle,
        ),
        Text(
          result.doctor.doctorLocation,
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
