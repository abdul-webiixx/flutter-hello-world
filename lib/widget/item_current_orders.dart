import 'package:flutter/cupertino.dart';
import 'package:Zenith/widget/item_order.dart';

class CurrentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(1),
        height: 200,
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(onTap: () {}, child: ItemCurrentItem()),
              );
            }));
  }
}
