import 'package:flutter/material.dart';
import 'package:Zenith/model/state.dart';
import 'package:Zenith/utils/widget_helper.dart';

class StateListDropdown extends StatefulWidget {
  final List<StateListItem>? stateList;
  final ValueChanged<StateListItem> onChanged;
  final StateListItem? defaultValue;
  final String hint;
  StateListDropdown(
      {Key? key,
      this.defaultValue,
      this.stateList,
      required this.onChanged,
      required this.hint})
      : super(key: key);
  @override
  _StateListDropdownState createState() => _StateListDropdownState();
}

class _StateListDropdownState extends State<StateListDropdown> {
  List<StateListItem>? stateList;
  StateListItem? selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 55,
      padding: EdgeInsets.only(top: 2),
      child: DropdownButton<StateListItem>(
        items: widget.stateList != null
            ? widget.stateList!.map((model) {
                return new DropdownMenuItem<StateListItem>(
                  value: model,
                  child: Text(model.name!, style: styleProvider()),
                );
              }).toList()
            : [],
        value: selectedItem == null ? widget.defaultValue : selectedItem,
        isExpanded: true,
        icon: Container(),
        onChanged: (StateListItem? model) {
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
