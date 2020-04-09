class Prescription {
  String treatment;
  int appintmentId;

  Prescription(this.treatment, this.appintmentId);

  Prescription.fromMap(Map map) {
    treatment = map[treatment];
    appintmentId = map[appintmentId];
  }
}

// patientid TEXT, datetime TEXT, doctorid TEXT) .toIso8601String()