import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tua/constants/colors.dart';
import 'package:tua/constants/textstyles.dart';
import 'package:tua/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:tua/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<TransferCubit>(create: (_) => TransferCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tua',
        theme: ThemeData(
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme: const ColorScheme.light(
                primary: ApplicationColors.primaryColor),
            primaryColor: ApplicationColors.primaryColor,
            primarySwatch: Colors.purple,
            scaffoldBackgroundColor: ApplicationColors.primaryColor,
            fontFamily: GoogleFonts.ubuntu().fontFamily,
            textTheme: TextTheme(
                bodyMedium: TextStyles.bodyText,
                bodySmall: TextStyles.bodyText,
                displayLarge: TextStyles.h1,
                displayMedium: TextStyles.h2,
                displaySmall: TextStyles.h3)),
        home: const LandingScreen(),
      ),
    );
  }
}
