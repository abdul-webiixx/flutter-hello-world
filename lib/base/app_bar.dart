import 'package:flutter/material.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/widget_helper.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final String? title;
  final Size? height;
  final bool? isLeading;
  final bool? isSuffixIcon;
  @override
  final Size preferredSize;
  BaseAppBar(
      {Key? key,
      this.suffixIcon,
      this.height,
      this.isLeading,
      this.prefixIcon,
      this.isSuffixIcon,
      this.title,
      this.backgroundColor})
      : preferredSize = height != null ? height : Size.fromHeight(50.0),
        super(key: key);
  @override
  _BaseAppBarState createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor != null
          ? widget.backgroundColor
          : Theme.of(context).backgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.title != null ? widget.title! : "",
            style: styleProvider(
                size: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorLight)),
        centerTitle: true,
      ),
      leading: widget.isLeading != null
          ? widget.isLeading!
              ? backButton()
              : !widget.isLeading! && widget.prefixIcon != null
                  ? widget.prefixIcon
                  : Container()
          : Container(),
      actions: <Widget>[
        widget.isSuffixIcon != null
            ? widget.isSuffixIcon!
                ? searchButton()
                : !widget.isSuffixIcon! && widget.suffixIcon != null
                    ? widget.suffixIcon!
                    : Container()
            : Container()
      ],
    );
  }

  Widget backButton() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Icon(
                CustomIcons.left_arrow,
                size: 12,
                color: Theme.of(context).primaryColorLight,
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget searchButton() {
    return GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Icon(
                Icons.search,
                color: Theme.of(context).primaryColorLight,
                size: 15,
              ),
            )
          ],
        ));
  }
}
