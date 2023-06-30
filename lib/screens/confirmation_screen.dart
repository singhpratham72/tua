import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/apis/transfer_api.dart';
import 'package:tua/constants/colors.dart';
import 'package:tua/constants/textstyles.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/models/transfer_model.dart';
import 'package:tua/screens/landing_screen.dart';
import 'package:tua/utils.dart';
import 'package:tua/widgets/custom_button.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool loading = true;
  bool success = false;
  Transfer? transfer, result;

  @override
  void initState() {
    super.initState();
    var transferProvider =
        BlocProvider.of<TransferCubit>(context, listen: false);
    transfer = transferProvider.transfer;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _callTransferAPI();
    });
  }

  void _callTransferAPI() async {
    TransferAPI _transferAPI = TransferAPI();
    result = await _transferAPI.createTransfer(transfer!);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: ApplicationColors.white,
          ),
        ),
      );
    } else {
      if (result != null) {
        return Scaffold(
          body: SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    FadedScaleAnimation(
                      child: const CircleAvatar(
                        radius: 42.0,
                        backgroundColor: ApplicationColors.white,
                        child: Icon(
                          Icons.check,
                          size: 48.0,
                          color: ApplicationColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      '\$ ${result?.amount.formatCurrency() ?? ''}',
                      style: TextStyles.h1.copyWith(fontSize: 36.0),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      'ID: ${result?.transferId}',
                      style: TextStyles.bodyText,
                    ),
                    const Divider(
                      height: 72.0,
                      thickness: 1.0,
                      color: ApplicationColors.grey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('From (Sender)',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2.0),
                              Text(
                                '${result?.sender?.fullName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'A/C: ${result?.senderBankDetails?.accountNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'Bank: ${result?.senderBankDetails?.bankName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('To (Beneficiary)',
                                  style: TextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2.0),
                              Text('${result?.beneficiary?.accountHolderName}'),
                              const SizedBox(height: 2.0),
                              Text(
                                'A/C: ${result?.beneficiary?.accountNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'Bank: ${result?.beneficiary?.bankName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 72.0,
                      thickness: 1.0,
                      color: ApplicationColors.grey,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Done',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingScreen()),
                            (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    FadedScaleAnimation(
                      child: const CircleAvatar(
                        radius: 42.0,
                        backgroundColor: ApplicationColors.white,
                        child: Icon(
                          Icons.close,
                          size: 48.0,
                          color: ApplicationColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      '\$${transfer?.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: TextStyles.h1.copyWith(fontSize: 36.0),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      'The transfer has failed due to an error.\nWe are sorry for the inconvenience.',
                      style: TextStyles.bodyText,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      height: 72.0,
                      thickness: 1.0,
                      color: ApplicationColors.grey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('From (Sender)',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2.0),
                              Text(
                                '${transfer?.sender?.fullName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'A/C: ${transfer?.senderBankDetails?.accountNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'Bank: ${transfer?.senderBankDetails?.bankName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('To (Beneficiary)',
                                  style: TextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2.0),
                              Text(
                                '${transfer?.beneficiary?.accountHolderName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'A/C: ${transfer?.beneficiary?.accountNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'Bank: ${transfer?.beneficiary?.bankName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 72.0,
                      thickness: 1.0,
                      color: ApplicationColors.grey,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Try Again',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingScreen()),
                            (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
