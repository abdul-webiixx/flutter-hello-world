import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/tawk/tawk_visitor.dart';
import 'package:Zenith/utils/tawk/tawk_widget.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'oops.dart';

class SupportScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  SupportScreen({Key? key, required this.userName, required this.userEmail})
      : super(key: key);
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late FirebaseService _firebaseService;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        authRequired: true,
        fullScreen: true,
        onModelReady: (model, userId, userType) {
          _firebaseService = new FirebaseService();
          model
              .getChatSupport(userId!)
              .then((value) => null)
              .onError((error, stackTrace) {
            _firebaseService.firebaseJsonError(
                apiCall: "fetchChatSupport",
                stackTrace: stackTrace,
                message: error.toString());
          });
        },
        builder: (context, model, child) {
          return pageProvider(model);
        });
  }

  Widget pageProvider(AppViewModel provider) {
    if (provider.authKeyModel.status != null &&
        provider.authKeyModel.requestStatus == RequestStatus.loaded &&
        provider.authKeyModel.data != null) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Tawk(
              directChatLink: provider.authKeyModel.success! &&
                      provider.authKeyModel.data != null &&
                      provider.authKeyModel.data!.key != null
                  ? provider.authKeyModel.data!.key!
                  : direct_chat_link,
              visitor: TawkVisitor(
                name: widget.userName,
                email: widget.userEmail,
              ),
              onLoad: () {
                print('Hello User!');
              },
              onLinkTap: (String url) {
                print(url);
              },
              placeholder: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    'Loading...',
                    style:
                        styleProvider(color: Theme.of(context).backgroundColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (provider.authKeyModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.authKeyModel.requestStatus),
        message: provider.authKeyModel.requestStatus == RequestStatus.failure
            ? provider.failure.message
            : null,
      );
    }
  }

  Widget pageBuilder(String link) {
    return SafeArea(
        child: Container(
      child: Tawk(
        directChatLink: link,
        visitor: TawkVisitor(
          name: widget.userName,
          email: widget.userEmail,
        ),
        onLoad: () {
          print('Hello User!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(
              'Loading...',
              style: styleProvider(color: Theme.of(context).backgroundColor),
            ),
          ),
        ),
      ),
    ));
  }
}
