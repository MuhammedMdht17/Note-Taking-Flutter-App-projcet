import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:note_taking/constants/theme.dart';

import 'constants/theme_services.dart';
import 'routing/app_pages.dart';
import 'routing/app_routes.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Note App by flutter",
        initialRoute: AppRoute.HOME,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        getPages: getRoutes);
  }
}
