import 'dart:async';
import 'dart:io' as io;
import 'package:doctor_patient/models/appointment_model.dart';
// import 'package:doctor_patient/models/doctor_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database _db;
  final String _dbName = "test8.db";

  static final _appoint = 'Appointments';
  static final _id = 'id';
  static final _apPatientId = 'patient_id';
  static final _apDateTime = 'date_time';
  static final _apDoctorId = 'doctor_id';
  static final _apStatus = 'status';

  static final _pres = 'Prescriptions';
  static final _presTreat = 'treatment';
  static final _appointId = 'appoint_Id';

  static final _doctor = 'Doctors';
  static final _doctorId = 'doc_id';
  static final _doctorName = 'doc_name';
  static final _doctorLocation = 'doc_location';

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    // await db.execute("CREATE TABLE Doctor(id INTEGER PRIMARY KEY, fullname TEXT, doctorid TEXT)");

    await db.execute('''
            CREATE TABLE $_appoint (
              $_id INTEGER PRIMARY KEY UNIQUE,
              $_apPatientId TEXT,
              $_apDateTime INTEGER,
              $_apDoctorId TEXT,
              $_apStatus INTEGER)
              ''');

    await db.execute('''
            CREATE TABLE $_doctor (
              $_id INTEGER PRIMARY KEY UNIQUE,
              $_doctorId TEXT,
              $_doctorName TEXT,
              $_doctorLocation TEXT)
              ''');

    // await db.execute("CREATE TABLE $_pres ($_apId INTEGER PRIMARY KEY, $_presTreat TEXT, $_appointId INTEGER");

    // String patient = "AAN2020";
    // int time = 1586444411361095;
    String doctor = "RASHIDSYL1";
    // int status = 0;

    String docName = "Dr. Rashidul Alam";
    String docLocation = "Sylhet Osmani Medical Hospital, Sylhet";

    // await db.rawInsert('INSERT INTO $_appoint($_apPatientId, $_apDateTime, $_apDoctorId, $_apStatus) VALUES(?, ?, ?, ?)', [patient, time, doctor, status]);

    await db.rawInsert(
        'INSERT INTO $_doctor($_doctorId, $_doctorName, $_doctorLocation) VALUES(?, ?, ?)',
        [doctor, docName, docLocation]);

    // await db.rawUpdate('UPDATE $_appoint SET $_apDateTime = "1587664800000000" WHERE $_apId = 1 ' );

    print("Created tables");
  }

  Future deleteData() async {
    var dbClient = await db;

    await dbClient
        .rawDelete('DELETE FROM $_appoint WHERE $_apDateTime = "1586429786" ');

    await dbClient.rawInsert(
        'INSERT INTO $_appoint ($_apPatientId, $_apDateTime, $_apDoctorId, $_apStatus) VALUES("AAN2020", 1587664800000000, "RASHIDSYL1", 0)');

    // await dbClient
    //     .rawDelete('DELETE FROM $_appoint WHERE $_apDoctorId = "Rashidul" ');
    // await dbClient.rawInsert(
    //     'INSERT INTO $_appoint ($_apPatientId, $_apDateTime, $_apDoctorId, $_apStatus) VALUES("AAN2020", 1587664800000000, "RASHIDSYL1", 0)');
  }

  //////// PATIENT VIEW -> 2 QUERY Show All Appointments of his patientID and in two sections:  1. Pending, 2. Done
  /// INSERT a new Appointment,

  Future<List<Map>> getPatientAppointments(String patientId) async {
    var dbClient = await db;
    try {
      List<Map> list = await dbClient.rawQuery(
          "SELECT * FROM $_appoint LEFT JOIN $_doctor ON $_appoint.$_apDoctorId = $_doctor.$_doctorId WHERE $_apPatientId = ? ",
          [patientId]);
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future insertNewAppointment(int time, String docId) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          'INSERT INTO $_appoint($_apPatientId, $_apDateTime, $_apDoctorId, $_apStatus) VALUES(?, ?, ?, ?)',
          ["AAN2020", time, docId, 0]);
    } catch (e) {
      print(e);
    }
  }

  Future removeData(int value) async {
    var dbClient = await db;
    try {
      await dbClient
          .rawDelete('DELETE FROM $_appoint WHERE $_apDateTime = ? ', [value]);
    } catch (e) {
      print(e);
    }
  }

  //////// DOCTOR VIEW -> QUERY to get All Appointments of his doctorID with: 1. Pending, 2. Previous (Done)
  /// Update an appointment

  // void saveDoctor(Doctor doctor) async {
  //   var dbClient = await db;
  //   await dbClient.transaction((txn) async {
  //     return await txn.rawInsert(
  //         'INSERT INTO Doctor(fullname, doctorid) VALUES(' +
  //             ''' +
  //             doctor.fullName +
  //             ''' +
  //             ',' +
  //             ''' +
  //             doctor.doctorId +
  //             ''' +
  //             ')');
  //   });
  // }

  Future<List<Map>> getDoctorAppointments(String doctorId) async {
    var dbClient = await db;
    int status = 0;
    try {
      List<Map> list = await dbClient.rawQuery(
          "SELECT * FROM $_appoint WHERE $_apDoctorId = ? AND $_apStatus = ?",
          [doctorId, status]);
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }

// import 'dart:async';
// import 'package:flutter_sqlite_demo/models/model.dart';
// import 'package:sqflite/sqflite.dart';

// abstract class DB {

//     static Database _db;

//     static int get _version => 1;

//     static Future<void> init() async {

//         if (_db != null) { return; }

//         try {
//             String _path = await getDatabasesPath() + 'example';
//             _db = await openDatabase(_path, version: _version, onCreate: onCreate);
//         }
//         catch(ex) {
//             print(ex);
//         }
//     }

//     static void onCreate(Database db, int version) async =>
//         await db.execute('CREATE TABLE todo_items (id INTEGER PRIMARY KEY NOT NULL, task STRING, complete BOOLEAN)');

//     static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

//     static Future<int> insert(String table, Model model) async =>
//         await _db.insert(table, model.toMap());

//     static Future<int> update(String table, Model model) async =>
//         await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

//     static Future<int> delete(String table, Model model) async =>
//         await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
// }

}
