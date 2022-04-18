import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemCart extends StatelessWidget {
  final CartItem item;
  final GestureTapCallback onPressed;
  ItemCart({required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: SizeConfig.screenWidth! - 200,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  item.productName!,
                  style: styleProvider(
                    size: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth! - 150,
                child: Text(
                  item.description != null
                      ? "${parse(item.description).documentElement!.text}"
                      : "",
                  style: styleProvider(
                    size: 10,
                    fontWeight: thin,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onPressed,
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: Theme.of(context).primaryColorLight,
                    )),
              ),
              Text(
                "₹ ${item.price!.toString()}",
                style: styleProvider(
                    size: 16,
                    fontWeight: semiBold,
                    color: Theme.of(context).primaryColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
