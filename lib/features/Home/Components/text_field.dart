import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TextFormFieldCustom1 extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String?)? onSaved;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final String obscuringCharacter;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final dynamic maxLines;
  final dynamic action;
  final dynamic errorText;

  const TextFormFieldCustom1({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    required this.controller,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.enabled = true,
    this.hintStyle,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter = '*',
    this.height = 60,
    this.width,
    this.maxLines = 1,
    this.action,
    this.errorText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width,
          minWidth: MediaQuery.sizeOf(context).width - (140),
        ),
        child: TextFormField(
          style: TextStyle(fontSize: 16, color: Colors.black),
          obscuringCharacter: obscuringCharacter,
          controller: controller,
          onTap: onTap,
          obscureText: obscureText,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          keyboardType: action != null ? TextInputType.multiline : keyboardType,
          maxLines: maxLines,
          textInputAction: action,
          decoration: InputDecoration(
            isDense: false,

            contentPadding: EdgeInsets.only(
                left: prefixIcon == null ? 20 : 10, top: 12, bottom: 12),
            hintText: hintText,
            hintStyle: hintStyle ??
                TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).hintColor,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: const OutlineInputBorder(
              // gapPadding: 3,

              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            errorText: errorText,
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            // onSaved: (newValue) => onSaved,
            // onChanged: onChanged,
            // onFieldSubmitted: onFieldSubmitted,
          ),
        ));
  }
}
