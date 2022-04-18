import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/login_view.dart';
import 'package:Zenith/widget/sign_up_view.dart';

class LoginSignUpScreen extends StatefulWidget {
  LoginSignUpScreen({Key? key}) : super(key: key);
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    new Tab(
      child: new Container(
        width: 150.0,
        child: new Tab(
          text: 'Login',
        ),
      ),
    ),
    new Tab(
        child: new Container(
      width: 150.0,
      child: new Tab(text: 'Sign Up'),
    )),
  ];
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 80),
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ic_logo,
                height: 80,
                width: 156,
              ),
              Container(
                  color: Theme.of(context).backgroundColor,
                  height: MediaQuery.of(context).size.height - 200,
                  child: new DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        backgroundColor: Theme.of(context).backgroundColor,
                        appBar: AppBar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          elevation: 0,
                          bottom: new PreferredSize(
                            preferredSize: new Size(200.0, 0.0),
                            child: Container(
                              child: TabBar(
                                  controller: _tabController,
                                  labelColor:
                                      Theme.of(context).primaryColorLight,
                                  unselectedLabelStyle: styleProvider(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelStyle: styleProvider(
                                      size: 16,
                                      fontWeight: medium,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  indicator: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0,
                                  ))),
                                  tabs: myTabs),
                            ),
                          ),
                        ),
                        body: Container(
                          color: Theme.of(context).backgroundColor,
                          child: new TabBarView(
                              controller: _tabController,
                              children: [LoginView(), SignUpView()]),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
