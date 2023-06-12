import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/constants/colors.dart';
import 'package:tua/constants/textstyles.dart';

class DefaultTextInput extends StatelessWidget {
  const DefaultTextInput(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.maxLength,
      this.obscureText = false,
      this.onTap,
      this.readOnly = false,
      this.validator,
      this.inputFormatters})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool obscureText;
  final Function? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        cursorColor: ApplicationColors.focusedGrey,
        validator: validator,
        style: TextStyles.bodyText.copyWith(fontSize: 18.0),
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelStyle: TextStyles.greyText,
          labelText: labelText,
          counter: const SizedBox.shrink(),
          errorStyle: TextStyles.errorText,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ApplicationColors.errorColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ApplicationColors.errorColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          floatingLabelStyle: TextStyles.bodyText.copyWith(fontSize: 16.0),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ApplicationColors.disabledGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ApplicationColors.focusedGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
