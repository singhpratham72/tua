import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/constants/textstyles.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/models/transfer_model.dart';
import 'package:tua/screens/confirmation_screen.dart';
import 'package:tua/services/navigation_helper.dart';
import 'package:tua/widgets/appbar/title_bar.dart';
import 'package:tua/widgets/custom_button.dart';
import 'package:tua/widgets/amount_textfield.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  Transfer? transfer;
  bool error = true;

  @override
  void initState() {
    var transferProvider =
        BlocProvider.of<TransferCubit>(context, listen: false);
    transfer = transferProvider.transfer;
    super.initState();
  }

  void _submitAmount() async {
    if (!error) {
      int amount = int.parse(_amountController.value.text.replaceAll(',', ''));
      FocusManager.instance.primaryFocus?.unfocus();
      transfer?.updateAmount(amount);
      var transferProvider =
          BlocProvider.of<TransferCubit>(context, listen: false);
      transferProvider.updateTransfer(transfer!);
      await Future.delayed(const Duration(milliseconds: 200));
      NavigationHelper().pushAndRemoveU(context, const ConfirmationScreen());
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleBar(
                label: 'Enter amount',
              ),
              SizedBox(height: height * 0.035),
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 48.0,
                ),
              ),
              const SizedBox(height: 12.0),
              Text('Transfer to ${transfer?.beneficiary?.accountHolderName}',
                  style: TextStyles.bodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center),
              Text(
                  'A/C: ${transfer?.beneficiary?.accountNumber} (${transfer?.beneficiary?.bankName})',
                  style: TextStyles.bodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center),
              const SizedBox(height: 12.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '\$',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  const SizedBox(width: 4.0),
                  AmountTextField(
                    amountController: _amountController,
                    focusNode: _focusNode,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        if (int.parse(val) == 0) {
                          _amountController.clear();
                          setState(() {
                            error = true;
                          });
                        } else {
                          // Insert commas
                          _amountController.text = _amountController.text
                              .replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},');
                          _amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _amountController.text.length));

                          // Check if amount is between valid range
                          int amount = int.parse(
                              _amountController.value.text.replaceAll(',', ''));
                          if (amount < 100 || amount > 25000) {
                            setState(() {
                              error = true;
                            });
                          } else {
                            setState(() {
                              error = false;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    onSubmitted: (_) {
                      _submitAmount();
                    },
                  ),
                ],
              ),
              error
                  ? const Text(
                      'The amount should be \$100 to \$25,000',
                      style: TextStyles.errorText,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 12.0,
              ),
              const Text('Transfer via Tua'),
              const Spacer(),
              error
                  ? const SizedBox.shrink()
                  : CustomButton(
                      label: 'Make Payment',
                      onTap: () {
                        _submitAmount();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
