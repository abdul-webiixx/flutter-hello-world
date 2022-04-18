import 'dart:convert';
import 'dart:io';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/coupon.dart';
import 'package:Zenith/model/invoice.dart';
import 'package:Zenith/model/order.dart';
import 'package:Zenith/model/order_history.dart';
import 'package:Zenith/model/order_summary.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';

class CartService {
  late CartModel _cartModel;
  late CouponModel _couponModel;
  late OrderModel _orderModel;
  late OrderHistoryModel _orderHistoryModel;
  late ApiResponse _apiResponse;
  late SubscriptionModel _currentSubscriptionModel;
  late SubscriptionModel _pastSubscriptionModel;
  late SubscriptionModel _waitListSubscriptionModel;
  late OrderSummaryModel _orderSummaryModel;
  late InvoiceModel _invoiceModel;
  late FirebaseService _firebaseService;

  Future<CartModel> fetchCartData({required int userId}) async {
    _cartModel = new CartModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCartData);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _cartModel = new CartModel.fromJson(jsonDecode(response.body));
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _cartModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _cartModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _cartModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _cartModel;
  }

  Future<CartModel> fetchProductRemoveFromCart(
      {required int userId, required int productId}) async {
    _cartModel = new CartModel();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetProductRemoveFromCart);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'product_id': productId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _cartModel = new CartModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _cartModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _cartModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _cartModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _cartModel;
  }

  Future<CouponModel> fetchCouponData() async {
    _couponModel = new CouponModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCouponData);
    try {
      http.Response response = await http.get(url, headers: await authHeader());
      _couponModel = new CouponModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _couponModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _couponModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _couponModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _couponModel;
  }

  Future<CartModel> fetchApplyCoupon(
      {required int userId, required String couponCode}) async {
    _cartModel = new CartModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetApplyCoupon);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'coupon_code': couponCode,
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _cartModel = new CartModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _cartModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _cartModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _cartModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _cartModel;
  }

  Future<CartModel> fetchRemoveCoupon({required int userId}) async {
    _cartModel = new CartModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetRemoveCoupon);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _cartModel = new CartModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _cartModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _cartModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _cartModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _cartModel;
  }

  Future<OrderModel> fetchCreateOrder(
      {required int userId,
      required String name,
      required String address1,
      required String address2,
      required String city,
      required String state,
      required String zip,
      required String gstNo}) async {
    _couponModel = new CouponModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCreateOrder);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'name': name,
        'address1': address1,
        'address2': address2,
        'city': city,
        'state': state,
        'zip': zip,
        "gst_no": gstNo
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _orderModel = new OrderModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _orderModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _orderModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _orderModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _orderModel;
  }

  Future<ApiResponse> fetchCreateConfirmation(
      {required int userId,
      required String orderId,
      required String status}) async {
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetOrderConfirmation);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'order_id': orderId,
        'status': status
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<OrderSummaryModel> fetchOrderSummary({
    required int userId,
    required int orderId,
  }) async {
    _orderSummaryModel = new OrderSummaryModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetOrderSummary);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'order_id': orderId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _orderSummaryModel =
          new OrderSummaryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _orderSummaryModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _orderSummaryModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _orderSummaryModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _orderSummaryModel;
  }

  Future<OrderHistoryModel> fetchOrderHistory({required int userId}) async {
    _orderHistoryModel = new OrderHistoryModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetOrderHistory);
    try {
      Map<String, dynamic> paramBody = {'user_id': userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _orderHistoryModel =
          new OrderHistoryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _orderHistoryModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _orderHistoryModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _orderHistoryModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _orderHistoryModel;
  }

  Future<SubscriptionModel> fetchCurrentSubscription(
      {required int userId}) async {
    _currentSubscriptionModel = new SubscriptionModel();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetCurrentSubscription);
    try {
      Map<String, dynamic> paramBody = {'user_id': userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _currentSubscriptionModel =
          new SubscriptionModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _currentSubscriptionModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _currentSubscriptionModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _currentSubscriptionModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _currentSubscriptionModel;
  }

  Future<SubscriptionModel> fetchPastSubscription({required int userId}) async {
    _pastSubscriptionModel = new SubscriptionModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetPastSubscription);
    try {
      Map<String, dynamic> paramBody = {'user_id': userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _pastSubscriptionModel =
          new SubscriptionModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _pastSubscriptionModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _pastSubscriptionModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _pastSubscriptionModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _pastSubscriptionModel;
  }

  Future<SubscriptionModel> fetchWaitListSubscription(
      {required int userId}) async {
    _waitListSubscriptionModel = new SubscriptionModel();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetWaitListSubscription);
    try {
      Map<String, dynamic> paramBody = {'user_id': userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _waitListSubscriptionModel =
          new SubscriptionModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _waitListSubscriptionModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _waitListSubscriptionModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _waitListSubscriptionModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _waitListSubscriptionModel;
  }

  Future<InvoiceModel> fetchInvoiceData(
      {required int userId, required int orderId}) async {
    _invoiceModel = new InvoiceModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInvoice);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'order_id': orderId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _invoiceModel = new InvoiceModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _invoiceModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _firebaseService.firebaseDioError(
          apiCall: "fetchInvoiceData",
          userId: userId,
          message: "Authentication Error",
          code: "404|401",
        );
        _invoiceModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _firebaseService.firebaseDioError(
          apiCall: "fetchInvoiceData",
          userId: userId,
          message: "Server Error",
          code: "500|502",
        );
        _invoiceModel.requestStatus = RequestStatus.server;
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchInvoiceData",
        userId: userId,
        message: e.message,
      );
      throw Failure(e.message);
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchInvoiceData",
        userId: userId,
        message: e.message,
      );
      throw Failure(e.message);
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchInvoiceData",
        userId: userId,
        message: e.message,
      );
      throw Failure(e.message);
    }
    return _invoiceModel;
  }
}
