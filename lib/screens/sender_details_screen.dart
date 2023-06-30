import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/models/sender_model.dart';
import 'package:tua/models/transfer_model.dart';
import 'package:tua/screens/sender_bank_details_screen.dart';
import 'package:tua/widgets/appbar/title_bar.dart';
import 'package:tua/widgets/custom_button.dart';
import 'package:tua/widgets/default_text_input.dart';

import '../services/navigation_helper.dart';

class SenderDetailsScreen extends StatefulWidget {
  const SenderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SenderDetailsScreen> createState() => _SenderDetailsScreenState();
}

class _SenderDetailsScreenState extends State<SenderDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Transfer? transfer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var transferProvider =
        BlocProvider.of<TransferCubit>(context, listen: false);
    transfer = transferProvider.transfer;
    super.initState();
  }

  String? _validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value ?? '')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a phone number';
    }

    if (value?.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  String? _validatePANNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your PAN number';
    }
    final panRegex = RegExp(r'[A-Z]{3}[PCHABGJLFT]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}');

    if (value?.length != 10 || !panRegex.hasMatch(value ?? '')) {
      return 'Please enter a valid 10-digit PAN number';
    }
    return null;
  }

  void _submitDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      var sender = Sender(
          fullName: _nameController.text.toUpperCase().trim(),
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          nationalIdNumber: _idNumberController.text,
          address: _addressController.text.trim());
      transfer?.updateSender(sender);
      var transferProvider =
          BlocProvider.of<TransferCubit>(context, listen: false);
      transferProvider.updateTransfer(transfer!);
      await Future.delayed(const Duration(milliseconds: 200));
      NavigationHelper().push(context, const SenderBankDetailsScreen());
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
                      label: 'Enter sender details',
                    ),
                    const SizedBox(height: 8.0),
                    DefaultTextInput(
                      labelText: 'Full Name',
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    DefaultTextInput(
                      labelText: 'Email',
                      controller: _emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    DefaultTextInput(
                      labelText: 'Mobile Number',
                      controller: _phoneController,
                      maxLength: 10,
                      validator: _validatePhoneNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    DefaultTextInput(
                      labelText: 'PAN Number',
                      controller: _idNumberController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      validator: _validatePANNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]'))
                      ],
                      maxLength: 10,
                    ),
                    DefaultTextInput(
                      labelText: 'Address',
                      controller: _addressController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.streetAddress,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
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
