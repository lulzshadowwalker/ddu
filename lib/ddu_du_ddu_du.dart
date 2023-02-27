import 'package:ddu/theme/ddu_colors.dart';
import 'package:ddu/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DduDuDduDu extends StatelessWidget {
  const DduDuDduDu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ddu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: DduColors.gold,
          selectionColor: DduColors.white.withOpacity(0.4),
          selectionHandleColor: DduColors.deepPurple,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: GoogleFonts.pacifico().fontFamily,
            ),
      ),
      home: const Home(),
    );
  }
}
