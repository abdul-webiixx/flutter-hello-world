import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/my_class.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:flutter/material.dart';

class ItemMyClass extends StatelessWidget {
 final MyClassData model;
  const ItemMyClass({Key? key, required this.model}) : super(key: key);

 @override
  Widget build(BuildContext context) {
  return Container(
   margin: EdgeInsets.only(top: 10),
   height: 100,
   padding: EdgeInsets.all(10),
   decoration: BoxDecoration(
    color: highlightColor,
    borderRadius: BorderRadius.circular(15),
   ),
   child: Row(
    children: [
     Container(
         width: MediaQuery.of(context).size.width / 6,
         child: streamWidget(context)),
     Container(
      margin: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width /1.6,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
        Text("${model.className}",
            style: styleProvider(size: 12, fontWeight: regular)),
        Text(model.createdAt!=null ? dateTimeConverter(model.createdAt!) : "",
            style: styleProvider(
                size: 10,
                fontWeight: regular,
                color: Theme.of(context).hintColor)),
       ],
      ),
     ),
    ],
   ),
  );
 }
}
