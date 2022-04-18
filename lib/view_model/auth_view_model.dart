import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';

class AuthViewModel extends BaseModel{

  late UserStatus _userStatus;
  UserStatus get userStatus => _userStatus;
  late UserType _userType;
  UserType get userType => _userType;

  late int _userId;
  int get userId => _userId;
  AuthViewModel.initializer() {
    _userStatus = UserStatus.Processing;
    _userType = UserType.Student;
    getAuthorizedAccess();
    getUserAccess();
  }

  Future<void> getAuthorizedAccess() async {
    getUserId().then((value) {
      if(value!=null){
        _userId = value;
        _userStatus = UserStatus.Authorized;
      }else{
        _userStatus = UserStatus.Unauthorized;
      }
      notifyListeners();
    });
  }

  Future<void> getUserAccess() async {
    getUserType().then((value) {
      if(value!=null && value==3){
        _userType = UserType.Trainer;
        notifyListeners();
      }else{
        _userType = UserType.Student;
      }
      notifyListeners();
    });
  }

}