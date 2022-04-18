import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:Zenith/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/screen/edit_profile.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';
import 'oops.dart';

class UserProfileScreen extends StatefulWidget {
  final int userId;
  UserProfileScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(onModelReady: (model, userId, userType) {
      model
          .getProfileData(userId: widget.userId)
          .then((value) => null)
          .onError((error, stackTrace) {
        _firebaseService.firebaseJsonError(
            apiCall: "getProfileData",
            stackTrace: stackTrace,
            message: error.toString(),
            userId: widget.userId);
      });
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: BaseAppBar(
            title: "Account",
            isLeading: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: black,
            child: SingleChildScrollView(
              child: _pagerBuilder(model),
            ),
          ));
    });
  }

  Widget _pagerBuilder(UserViewModel provider) {
    if (provider.profileModel.success != null &&
        provider.profileModel.success &&
        provider.profileModel.requestStatus == RequestStatus.loaded) {
      return pageProvider(model: provider.profileModel.userInformation!);
    } else if (provider.profileModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.profileModel.requestStatus),
        message: provider.profileModel.requestStatus == RequestStatus.failure
            ? provider.failure.message
            : null,
      );
    }
  }

  Widget pageProvider({required UserInformation model}) {
    return Container(
      color: black,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(
                        imageUrl: model.avatar ?? thumbnail_user,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Image.network(
                          thumbnail_user,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width - 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Hi ${model.name ?? dummyUser}",
                            style: styleProvider(
                                fontWeight: semiBold,
                                size: 18,
                                color: Theme.of(context).primaryColorLight)),
                      ),
                      Text(
                          "Member Since: ${dateFormatter(model.createdAt ?? dummyDate)}",
                          style: styleProvider(
                              fontWeight: regular,
                              size: 10,
                              color: Theme.of(context).hintColor)),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          changeScreen(
                              context, EditProfileScreen(model: model));
                        },
                        child: Container(
                            width: 150,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFB60D),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30, top: 5, bottom: 5),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text('EDIT ACCOUNT',
                                        style: styleProvider(
                                            fontWeight: semiBold,
                                            size: 10,
                                            color: Theme.of(context)
                                                .backgroundColor)),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account Details",
                    style: styleProvider(
                        fontWeight: semiBold,
                        size: 14,
                        color: Theme.of(context).primaryColorLight)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [amber_700!, amber_400!]),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Icon(
                          CustomIcons.user,
                          color: Theme.of(context).backgroundColor,
                          size: 10,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("User Id: #${model.id ?? "not available"}",
                          style: styleProvider(
                              fontWeight: medium,
                              size: 12,
                              color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.contact_us,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.mobile ?? "{not available}",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                      Icon(
                        CustomIcons.edit,
                        color: Theme.of(context).hintColor,
                        size: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profile Details",
                          style: styleProvider(
                              fontWeight: semiBold,
                              size: 14,
                              color: Theme.of(context).primaryColorLight)),
                      GestureDetector(
                        onTap: () {
                          changeScreen(
                              context, EditProfileScreen(model: model));
                        },
                        child: Icon(
                          CustomIcons.edit,
                          color: Theme.of(context).hintColor,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.user,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${model.name ?? dummyUser}",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.email,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${model.email ?? dummyMail}",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.sex,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.gender ?? "Not Available",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.placeholder,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(model.address1 ?? "Not Available",
                                style: styleProvider(
                                    fontWeight: medium,
                                    size: 12,
                                    color: Theme.of(context).hintColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.cake,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.dob ?? dummyDOB,
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Billing Details",
                          style: styleProvider(
                              fontWeight: semiBold,
                              size: 14,
                              color: Theme.of(context).primaryColorLight)),
                      Icon(
                        CustomIcons.edit,
                        color: Theme.of(context).hintColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.user,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${model.name ?? dummyUser}",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.placeholder,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.address1 ?? "not available",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.placeholder,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.city ?? "not available",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              CustomIcons.placeholder,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text("not available",
                                style: styleProvider(
                                    fontWeight: medium,
                                    size: 12,
                                    color: Theme.of(context).hintColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [amber_700!, amber_400!]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Icon(
                              Icons.more_horiz,
                              color: Theme.of(context).backgroundColor,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(model.zip ?? "not available",
                              style: styleProvider(
                                  fontWeight: medium,
                                  size: 12,
                                  color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
