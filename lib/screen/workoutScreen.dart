import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/widget_helper.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        appBar: BaseAppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: _listCourses(),
        ),
      ),
    );
  }

  Widget _listCourses() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Container(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            childAspectRatio: (itemWidth / 165),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: ClampingScrollPhysics(),
            children: List.generate(
                4,
                (index) => GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Image.asset(
                                "assets/mokedata/mokeImage.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Dance Workout",
                              style: styleProvider(
                                size: 12,
                                fontWeight: medium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))));
  }
}
