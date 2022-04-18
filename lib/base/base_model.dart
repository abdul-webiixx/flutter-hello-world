import 'package:flutter/foundation.dart';
import 'package:Zenith/utils/enum.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  set state(ViewState viewState) {
    print('State:$viewState');
    _state = viewState;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}