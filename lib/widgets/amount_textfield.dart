import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/constants/colors.dart';
import 'package:tua/constants/textstyles.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    Key? key,
    required TextEditingController amountController,
    required FocusNode focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  })  : _amountController = amountController,
        _focusNode = focusNode,
        super(key: key);

  final TextEditingController _amountController;
  final FocusNode _focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: IntrinsicWidth(
        child: TextField(
          controller: _amountController,
          focusNode: _focusNode,
          style: TextStyles.textFieldStyle,
          cursorColor: ApplicationColors.white,
          textInputAction: TextInputAction.send,
          buildCounter: (
            context, {
            required int currentLength,
            required int? maxLength,
            required bool isFocused,
          }) {
            return const SizedBox.shrink();
          },
          decoration: InputDecoration.collapsed(
            hintText: '0',
            hintStyle: TextStyles.textFieldStyle
                .copyWith(color: ApplicationColors.white.withOpacity(0.5)),
          ),
          maxLength: 5,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autofocus: true,
          onTap: onTap,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          autocorrect: false,
          obscureText: false,
        ),
      ),
    );
  }
}
