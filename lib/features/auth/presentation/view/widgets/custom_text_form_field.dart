import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.onSaved,
      this.obscureText = false});
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        suffixIcon != null
            ? const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              )
            : hintText == 'name'
                ? const Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  )
                : const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
        TextFormField(
          obscureText: obscureText,
          onSaved: onSaved,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          keyboardType: textInputType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xff9AA0B0)),
            // label: Text("Email"),
            filled: true,
            fillColor: const Color(0xFFF9FAFA),
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xFFBCB5FA),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
