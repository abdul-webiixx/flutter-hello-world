import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemCurrentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        "Event Name",
                        style: styleProvider(
                          size: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      )),
                      Container(
                          child: Text(
                        "Belly Dance Course",
                        style: styleProvider(
                            size: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: medium),
                      ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        "Features",
                        style: styleProvider(
                          size: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      )),
                      Container(
                          child: Text(
                        "Live Classes",
                        style: styleProvider(
                            size: 14,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: medium),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        "Date",
                        style: styleProvider(
                          size: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      )),
                      Container(
                          child: Text(
                        "2nd February",
                        style: styleProvider(
                            size: 14,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: medium),
                      ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                          child: Text(
                        "End Date",
                        style: styleProvider(
                          size: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      )),
                      Container(
                          child: Text(
                        "2nd March",
                        style: styleProvider(
                            size: 14,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: medium),
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
