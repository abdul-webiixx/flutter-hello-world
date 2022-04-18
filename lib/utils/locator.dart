import 'package:Zenith/view_model/auth_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:Zenith/services/failure.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/user_view_model.dart';


GetIt locator = GetIt.instance;

void setLocator(){
  locator.registerSingleton(FailureService());
  locator.registerSingleton(FirebaseService());
  locator.registerLazySingleton(() => UserViewModel.initializer());
  locator.registerLazySingleton(() => AppViewModel.initializer());
  locator.registerLazySingleton(() => CourseViewModel.initializer());
  locator.registerLazySingleton(() => CartViewModel.initializer());
  locator.registerLazySingleton(() => ClassViewModel.initializer());
  locator.registerLazySingleton(() => AuthViewModel.initializer());
}