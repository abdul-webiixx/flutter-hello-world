// import 'package:Zenith/services/cart.dart';
// import 'package:Zenith/utils/data_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartIconProvider extends ChangeNotifier {
//   late CartService _cartService;

//   late int? _cartItemCount = 0;
//   int? get cartItemCount => _cartItemCount;

//   Future<void> getCartItemsCouunt() async {
//     getUserId().then((userId) {
//       _cartService.fetchCartData(userId: userId!).then((value) {
//         _cartItemCount = value.cartData!.cartItems!.length;
//         notifyListeners();
//       });
//       notifyListeners();
//     });
//     notifyListeners();
//   }
// }

import 'package:Zenith/view_model/app_view_model.dart';
import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ItemCount {
//   static int cartItemcount = 0;
//   static seticondata(int? counter) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('counter', counter!);
//   }

//   static reduceitemcount() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? a = prefs.getInt("counter");
//     await prefs.setInt('counter', a! - 1);
//   }

//   static additemcount() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? a = prefs.getInt("counter");
//     await prefs.setInt('counter', a! + 1);
//   }

//   static Future<int?> getIcondata() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getInt('counter')!;
//   }
// }

class MProvider extends InheritedWidget {
  final timeOffBloc = AppViewModel.initializer();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  MProvider({Key? key, Widget? child}) : super(key: key, child: child!);

  static AppViewModel timeOffBlocOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MProvider>()!.timeOffBloc;
  }
}
