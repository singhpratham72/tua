import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/models/sender_bank_details_model.dart';
import 'package:tua/models/transfer_model.dart';
import 'package:tua/screens/beneficiary_details_screen.dart';
import 'package:tua/widgets/appbar/title_bar.dart';
import 'package:tua/widgets/custom_button.dart';
import 'package:tua/widgets/default_text_input.dart';
import '../services/navigation_helper.dart';

class SenderBankDetailsScreen extends StatefulWidget {
  const SenderBankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SenderBankDetailsScreen> createState() =>
      _SenderBankDetailsScreenState();
}

class _SenderBankDetailsScreenState extends State<SenderBankDetailsScreen> {
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
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
    if (value!.length < 9 || value.length > 18) {
      return 'A/C number should be 9-18 digits';
    }
    return null;
  }

  String? _validateIFSC(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your IFSC code';
    }
    if (value?.length != 11) {
      return 'Please enter an 11-digit IFSC code';
    }

    RegExp regex = RegExp(r'^[A-Za-z]{4}[A-Za-z0-9]{7}$');
    if (!regex.hasMatch(value ?? '')) {
      return 'IFSC Code Format: ABCD0000000';
    }
    return null;
  }

  void _submitDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      var senderBankDetails = SenderBankDetails(
          bankName: _bankNameController.text.toUpperCase().trim(),
          accountNumber: _accountNumberController.text,
          ifscCode: _ifscController.text.toUpperCase().trim());
      transfer?.updateSenderBankDetails(senderBankDetails);
      var transferProvider =
          BlocProvider.of<TransferCubit>(context, listen: false);
      transferProvider.updateTransfer(transfer!);
      await Future.delayed(const Duration(milliseconds: 200));
      NavigationHelper().push(context, const BeneficaryDetailsScreen());
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
                      label: 'Enter your bank details',
                    ),
                    const SizedBox(height: 8.0),
                    DefaultTextInput(
                      labelText: 'Bank Name',
                      controller: _bankNameController,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your bank\u2019s name';
                        }
                        return null;
                      },
                    ),
                    DefaultTextInput(
                      labelText: 'Account Number',
                      controller: _accountNumberController,
                      maxLength: 18,
                      validator: _validateAccountNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    DefaultTextInput(
                        labelText: 'IFSC Code',
                        controller: _ifscController,
                        keyboardType: TextInputType.text,
                        validator: _validateIFSC,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
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
