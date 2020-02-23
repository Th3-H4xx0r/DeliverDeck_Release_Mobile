import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final Icon icon;
  final String name;
  final Color settingColor;
  final bool isSwitched;
  Setting(this.icon,this.name,this.settingColor, this.isSwitched);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          child: widget.icon,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13), color: widget.settingColor),
        ),
        title: Text(widget.name),
        trailing: Container(
          margin: EdgeInsets.only(right: 20),
          padding: const EdgeInsets.only(right:20),
          child: CupertinoSwitch(
            activeColor: widget.settingColor,
            value: widget.isSwitched,
            onChanged: (value) {setState(() {
              value = widget.isSwitched;
            });},
          ),
        ),
      ),
    );
  }
}