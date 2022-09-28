import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SectiontitleComponent extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData icon;
  final Function() onTap;
  const SectiontitleComponent(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // ignore: deprecated_member_use
            color: ThemeProvider.themeOf(context).data.accentColor),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: TextStyle(
                  // ignore: deprecated_member_use
                  color: ThemeProvider.themeOf(context).data.accentColor),
            )
          : null,
      trailing: Icon(
        icon,
        // ignore: deprecated_member_use
        color: ThemeProvider.themeOf(context).data.accentColor,
      ),
      onTap: onTap,
    );
  }
}

class SectiontitleSwitchComponent extends StatelessWidget {
  final String title;
  final bool valueSwitch;
  final Function(bool) onChangedSwitch;
  const SectiontitleSwitchComponent(
      {Key? key,
      required this.title,
      required this.valueSwitch,
      required this.onChangedSwitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // ignore: deprecated_member_use
            color: ThemeProvider.themeOf(context).data.accentColor),
      ),
      trailing: CupertinoSwitch(
        activeColor: ThemeProvider.themeOf(context).data.primaryColorLight,
        value: valueSwitch,
        onChanged: onChangedSwitch,
      ),
    );
  }
}


class SectiontitleSwitchWidget extends StatelessWidget {
  final Widget widget;
  final bool valueSwitch;
  final Function(bool) onChangedSwitch;
  const SectiontitleSwitchWidget(
      {Key? key,
      required this.widget,
      required this.valueSwitch,
      required this.onChangedSwitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget,
      trailing: CupertinoSwitch(
        activeColor: ThemeProvider.themeOf(context).data.primaryColorLight,
        value: valueSwitch,
        onChanged: onChangedSwitch,
      ),
    );
  }
}