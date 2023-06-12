import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/models/beneficiary_model.dart';
import 'package:tua/models/transfer_model.dart';
import 'package:tua/screens/amount_screen.dart';
import 'package:tua/services/navigation_helper.dart';
import 'package:tua/widgets/appbar/title_bar.dart';
import 'package:tua/widgets/custom_button.dart';
import 'package:tua/widgets/default_text_input.dart';

class BeneficaryDetailsScreen extends StatefulWidget {
  const BeneficaryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BeneficaryDetailsScreen> createState() =>
      _BeneficaryDetailsScreenState();
}

class _BeneficaryDetailsScreenState extends State<BeneficaryDetailsScreen> {
  final TextEditingController _accountHolderName = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _swiftCodeController = TextEditingController();
  final TextEditingController _routingNumberController =
      TextEditingController();
  Transfer? transfer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var transferProvider =
        BlocProvider.of<TransferCubit>(context, listen: false);
    transfer = transferProvider.transfer;
    super.initState();
  }

  String? _validateAccountNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter an account number';
    }
    if (value!.length < 10 || value.length > 12) {
      return 'A/C number should be 10-12 digits';
    }
    return null;
  }

  String? _validateSwiftCode(String? value) {
    if (value?.isEmpty ?? false) {
      return 'Please enter the Bank Swift Code';
    }

    if (value!.length < 8 || value.length > 11) {
      return 'Bank Swift Code should be 8-11 characters';
    }
    return null;
  }

  String? _validateRoutingNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter the Bank Routing Number';
    }
    if (value?.length != 9) {
      return 'Please enter a 9-digit Routing Number';
    }
    return null;
  }

  void _submitDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      var benfeciaryDetails = Beneficiary(
          accountHolderName: _accountHolderName.text.toUpperCase().trim(),
          accountNumber: _accountNumberController.text,
          bankName: _bankNameController.text.toUpperCase().trim(),
          swiftCode: _swiftCodeController.text,
          routingNumber: _routingNumberController.text);
      transfer?.updateBeneficiary(benfeciaryDetails);
      var transferProvider =
          BlocProvider.of<TransferCubit>(context, listen: false);
      transferProvider.updateTransfer(transfer!);
      await Future.delayed(const Duration(milliseconds: 200));
      NavigationHelper().push(context, const AmountScreen());
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            height: height,
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleBar(
                      label: 'Enter beneficiary details',
                    ),
                    const SizedBox(height: 8.0),
                    DefaultTextInput(
                      labelText: 'Account Holder Name',
                      controller: _accountHolderName,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the beneficiary\u2019s name';
                        }
                        return null;
                      },
                    ),
                    DefaultTextInput(
                      labelText: 'Account Number',
                      controller: _accountNumberController,
                      maxLength: 12,
                      validator: _validateAccountNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    DefaultTextInput(
                      labelText: 'Bank Name',
                      controller: _bankNameController,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the bank\u2019s name';
                        }
                        return null;
                      },
                    ),
                    DefaultTextInput(
                        labelText: 'Bank Swift Code',
                        controller: _swiftCodeController,
                        keyboardType: TextInputType.number,
                        validator: _validateSwiftCode,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
                        ]),
                    DefaultTextInput(
                        labelText: 'Bank Routing Number',
                        controller: _routingNumberController,
                        keyboardType: TextInputType.number,
                        validator: _validateRoutingNumber,
                        maxLength: 9,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                    const Spacer(),
                    CustomButton(
                      label: 'Continue',
                      onTap: () {
                        _submitDetails();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
