class Patient {
  int id;
  String patientId;
  String patientName;
  String patientAge;

  Patient({this.id, this.patientId, this.patientName, this.patientAge});

  Patient.fromMap(Map map) {
    id = map[id];
    patientId = map[patientId];
    patientName = map[patientName];
    patientAge = map[patientAge];
  }  
}