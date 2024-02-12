import 'package:flutter/material.dart';

class BuildFormField extends StatelessWidget {
  const BuildFormField({
    Key? key,
    this.maxLines = 1,
    this.textInputAction,
    // this.contentPadding = 0.0,
    this.keyboardType,
    this.validator,
    this.fieldName,
    this.prefixIcon,
    this.style,
    this.initialValue,
    this.onFieldSubmitted,
    this.onSaved,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.textDirection,
    this.labelStyle,
    this.onChanged,
    this.fillColor,
  }) : super(key: key);

  final void Function(String)? onFieldSubmitted;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? fieldName;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  // final double? contentPadding;
  final TextEditingController? controller;
  final bool obscureText;
  final String? initialValue;
  final Color? fillColor;
  final int? maxLines;
  final TextDirection? textDirection;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide.none,
          borderSide: BorderSide.none, // const BorderSide(color: Colors.black26),
        ),
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: fieldName,
        filled: true,
        fillColor: fillColor ?? Theme.of(context).cardColor,
        focusColor: Theme.of(context).colorScheme.primary,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // label: Text(fieldName!),
        // contentPadding: EdgeInsets.all(contentPadding!),
      ),
      // strutStyle: const  StrutStyle(
      //   fontSize: 16.0,
      //   height: 1.5, // Set the desired strut height
      //   leading: 0.5, // Set the desired leading
      // ),
      maxLines: maxLines,
      cursorColor: Theme.of(context).primaryColor,
      textDirection: textDirection,
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      obscureText: obscureText,
      style: style,
      onChanged: onChanged,
    );
  }
}
