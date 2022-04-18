import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';

class DemoClassesScreen extends StatefulWidget {
  @override
  _DemoClassesScreenState createState() => _DemoClassesScreenState();
}

class _DemoClassesScreenState extends State<DemoClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 120),
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            appBar: BaseAppBar(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Belly Dance Demo Classes",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColorLight)),
                  Text("4 Classes | 34 lessons",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).hintColor)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _listNotifiers(),
      ),
    );
  }

  Widget _listNotifiers() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: GestureDetector(onTap: () {}, child: Container()),
          );
        });
  }
}
