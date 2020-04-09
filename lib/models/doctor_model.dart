class Doctor {
  int id;
  String doctorId;
  String doctorName;
  String doctorLocation;

  Doctor({this.id, this.doctorId, this.doctorName, this.doctorLocation});

  Doctor.fromMap(Map map) {
    id = map[id];
    doctorId = map[doctorId];
    doctorName = map[doctorName];
    doctorLocation = map[doctorLocation];
  }

  static List<Doctor> getDoctors() {
    return <Doctor>[
      Doctor(
        doctorId: "RASHIDSYL1",
        doctorName: "Dr. Rashidul Alam",
        doctorLocation: "Sylhet Osmani Medical Hospital",
      ),
    ];
  }
}