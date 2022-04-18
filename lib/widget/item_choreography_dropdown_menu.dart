import 'package:Zenith/model/choreography.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ChoreographyListDropdown extends StatefulWidget {
  final List<ChoreographyData>? list;
  final ValueChanged<ChoreographyData> onChanged;
  final bool? disable;
  final ChoreographyData? defaultValue;
  final String hint;
  ChoreographyListDropdown(
      {Key? key,
      this.defaultValue,
      this.list,
      required this.onChanged,
      required this.hint,
      this.disable})
      : super(key: key);
  @override
  _ChoreographyListDropdownState createState() =>
      _ChoreographyListDropdownState();
}

class _ChoreographyListDropdownState extends State<ChoreographyListDropdown> {
  List<ChoreographyData>? choreographyList;
  ChoreographyData? selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 2),
      child: DropdownButton<ChoreographyData>(
        items: widget.list != null
            ? widget.list!.map((model) {
                return new DropdownMenuItem<ChoreographyData>(
                  value: model,
                  child: Text(model.name!, style: styleProvider()),
                );
              }).toList()
            : [],
        value: selectedItem == null ? widget.defaultValue : selectedItem,
        isExpanded: true,
        icon: Container(),
        onChanged: widget.disable != null && widget.disable!
            ? null
            : (ChoreographyData? model) {
                setState(() {
                  this.selectedItem = model;
                });
                widget.onChanged(model!);
              },
        hint: Text(
          widget.hint,
          style: styleProvider(color: Theme.of(context).hintColor),
        ),
        underline: Container(),
      ),
    );
  }
}
