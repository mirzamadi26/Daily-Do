import 'package:daily_do/firebase_options.dart';
import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/app_theme.dart';
import 'package:daily_do/utils/route_generator.dart';
import 'package:daily_do/utils/screen_bindings.dart';
import 'package:daily_do/view/home/view/task_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);
    return baseTheme.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(baseTheme.textTheme),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      scaffoldBackgroundColor: kWhiteColor,
      colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      initialRoute: splashView,
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      initialBinding: ScreenBindings(),
      getPages: RouteGenerator.getPages(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0)),
            child: child!);
      },
    );
  }
}
