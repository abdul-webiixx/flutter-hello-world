import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/utils/locator.dart';
import 'base_model.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T model, int? userId, UserType? userType)? onModelReady;
  final bool? fullScreen;
  final bool? authRequired;
  BaseView(
      {required this.builder,
      this.onModelReady,
      this.fullScreen,
      this.authRequired});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();
  Future<int?>? userId;
  Future<UserType?>? userType;

  @override
  void initState() {
    initialTask();
    super.initState();
  }

  // @override
  // void dispose() {
  //   initialTask();
  //   super.dispose();
  // }

  Future<void> initialTask() async {
    if (widget.onModelReady != null) {
      if (widget.authRequired != null && widget.authRequired!) {
        widget.onModelReady!(
            model, await getLoginUserId(), await getLoginUserType());
      } else {
        widget.onModelReady!(model, null, null);
      }
    }
  }

  Future<int?> getLoginUserId() => getUserId();

  Future<UserType?> getLoginUserType() async {
    var userType = await getUserType();
    if (userType != null && userType == 3) {
      return UserType.Trainer;
    } else {
      return UserType.Student;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: widget.fullScreen != null && widget.fullScreen!
          ? EdgeInsets.symmetric(horizontal: 0)
          : EdgeInsets.symmetric(horizontal: 20),
      child: ChangeNotifierProvider<T>.value(
        child: Consumer<T>(
          builder: widget.builder,
        ),
        value: model,
      ),
    );
  }
}
