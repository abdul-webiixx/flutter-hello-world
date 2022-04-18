import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';


class ItemSubscription extends StatelessWidget {
  final SubscriptionDetails model;
   ItemSubscription({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).highlightColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            child:  Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth!/2-30,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: styleProvider(
                          color: grey,
                          fontWeight: regular,
                          size: 12
                      ),),
                      Text(model.name!,
                        style: styleProvider(
                            color: primaryColor,
                            fontWeight: regular,
                            size: 14
                        ),),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: SizeConfig.screenWidth!/2-80,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Type",
                        style: styleProvider(
                            color: grey,
                            fontWeight: regular,
                            size: 12
                        ),),
                      Text(model.featuresName!,
                        style: styleProvider(
                            color: white,
                            fontWeight: regular,
                            size: 14
                        ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 60,
            child:  Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth!/2-30,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start Date",
                        style: styleProvider(
                            color: grey,
                            fontWeight: regular,
                            size: 12
                        ),),
                      Text(dateFormatter(model.startsAt!),
                        style: styleProvider(
                            color: white,
                            fontWeight: regular,
                            size: 14
                        ),)
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: SizeConfig.screenWidth!/2-80,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("End date",
                        style: styleProvider(
                            color: grey,
                            fontWeight: regular,
                            size: 12
                        ),),
                      Text(dateFormatter(model.endsAt!),
                        style: styleProvider(
                            color: white,
                            fontWeight: regular,
                            size: 14
                        ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Status:- ${model.status}",
                    style: styleProvider(
                    size: 10, fontWeight:regular,
                  ),),
                ),
                SizedBox(width: 5,),
                (model.featuresName=="Workshop")?Container():
              
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Remaining Class:- ${model.remainingClass ?? 0}",
                    style: styleProvider(
                      size: 10, fontWeight:regular,
                    ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
