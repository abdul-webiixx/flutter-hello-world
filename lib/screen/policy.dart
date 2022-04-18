import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class PolicyScreen extends StatefulWidget {
  final PolicyRequestFor requestFor;
  PolicyScreen({Key? key, required this.requestFor}) : super(key: key);
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(onModelReady: (model, userId, userType) {
      model.getPrivacyPolicy(requestFor: widget.requestFor);
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(
          title: _title(widget.requestFor),
          isLeading: true,
        ),
        body: SingleChildScrollView(
          child: pageUi(model),
        ),
      );
    });
  }

  Widget pageUi(AppViewModel provider) {
    if (provider.privacyPolicyModel.success != null &&
        provider.privacyPolicyModel.success &&
        provider.privacyPolicyModel.requestStatus == RequestStatus.loaded) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 20),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).highlightColor),
        child: Text(
          provider.privacyPolicyModel.privacyPolicyData != null
              ? parse(provider.privacyPolicyModel.privacyPolicyData!.content!)
                  .documentElement!
                  .text
              : "",
          style: styleProvider(
            fontWeight: regular,
            size: 12,
          ),
        ),
      );
    } else if (provider.privacyPolicyModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.privacyPolicyModel.requestStatus),
          message:
              provider.privacyPolicyModel.requestStatus == RequestStatus.failure
                  ? provider.failure.message
                  : null);
    }
  }

  String _title(PolicyRequestFor requestFor) {
    String title = "";
    switch (requestFor) {
      case PolicyRequestFor.AboutUs:
        title = "About Us";
        break;
      case PolicyRequestFor.PrivacyPolicy:
        title = "Privacy Policy";
        break;
      case PolicyRequestFor.TermsAndUse:
        title = "Terms And Condition";
        break;
    }
    return title;
  }
}
