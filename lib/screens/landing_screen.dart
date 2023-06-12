import 'package:flutter/material.dart';
import 'package:tua/constants/textstyles.dart';
import 'package:tua/screens/sender_details_screen.dart';
import 'package:tua/services/navigation_helper.dart';
import 'package:tua/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'tua',
                style: TextStyles.h1.copyWith(fontSize: 72.0),
              ),
              Text(
                '\nSeamless Global Payments\nAnytime. Anywhere.',
                textAlign: TextAlign.center,
                style: TextStyles.bodyText.copyWith(fontSize: 18.0),
              ),
              const Spacer(),
              CustomButton(
                label: 'Let\u2019s Begin',
                onTap: () {
                  NavigationHelper().push(context, const SenderDetailsScreen());
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
