// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {super.key,
      required this.name,
      required this.hintText,
      required this.controller,
      this.validator,
      this.onChange,
      this.isPassword = false,
      this.isPasswordVisible = false,
      this.suffixIcon});
  String? name;
  String? hintText;
  TextEditingController? controller;
  void Function(String?)? onChange;
  String? Function(String?)? validator;
  bool isPassword;
  bool isPasswordVisible;
  Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name!,
      obscureText: isPassword,
      controller: controller!,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}
