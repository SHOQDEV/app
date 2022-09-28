import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';
class InputComponent extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controllerText;
  final Function() onEditingComplete;
  final Function(String) validator;
  final bool obscureText;
  final Function()? onTap;
  final IconData? iconOnTap;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function()? onTapInput;
  final List<TextInputFormatter>? inputFormatters;
  const InputComponent({Key? key, 
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.controllerText,
    required this.onEditingComplete,
    required this.validator,

    this.icon,
    this.obscureText=false,
    this.onTap,
    this.iconOnTap,
    this.textCapitalization=TextCapitalization.none,
    this.onChanged,
    this.inputFormatters,
    this.onTapInput
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization : textCapitalization,
      // ignore: deprecated_member_use
      style: TextStyle(color:ThemeProvider.themeOf(context).data.accentColor),
      // ignore: deprecated_member_use
      cursorColor: ThemeProvider.themeOf(context).data.accentColor,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      validator: (text) => validator(text!),
      controller: controllerText,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onTap:onTapInput,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: ThemeProvider.themeOf(context).data.disabledColor
        ),
        icon: Icon(icon,
        color: ThemeProvider.themeOf(context).data.disabledColor),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(iconOnTap,
            color: ThemeProvider.themeOf(context).data.disabledColor,
          ),
        ),
        labelText: labelText),
    );
  }
}

class InputComponentNoIcon extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controllerText;
  final Function() onEditingComplete;
  final Function(String) validator;
  final bool obscureText;
  final Function()? onTap;
  final IconData? iconOnTap;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const InputComponentNoIcon({Key? key, 
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.controllerText,
    required this.onEditingComplete,
    required this.validator,
    this.obscureText=false,
    this.onTap,
    this.iconOnTap,
    this.textCapitalization=TextCapitalization.none,
    this.focusNode,
    this.onChanged,
    this.inputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode,
      // FocusNode: focusNode,
         autofocus:true,
      textCapitalization : textCapitalization,
      // ignore: deprecated_member_use
      style: TextStyle(color:ThemeProvider.themeOf(context).data.accentColor),
      // ignore: deprecated_member_use
      cursorColor: ThemeProvider.themeOf(context).data.accentColor,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      validator: (text) => validator(text!),
      onChanged:onChanged,
      controller: controllerText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: ThemeProvider.themeOf(context).data.disabledColor
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(iconOnTap,
            color: ThemeProvider.themeOf(context).data.disabledColor,
          ),
        ),
        labelText: labelText),
    );
  }
}