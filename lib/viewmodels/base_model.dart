import 'package:doctor_patient/constants/view_state.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;

    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}
