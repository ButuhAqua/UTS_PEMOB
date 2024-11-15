import 'package:flutter/material.dart';

import 'core/navigation/navigation_service.dart';
import 'domain/usecases/navigate_to_page.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/pages/deskripsi_page.dart';
import 'presentation/pages/maps_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize services and controllers
    final navigationService = NavigationService();
    final navigateToPageUseCase = NavigateToPageUseCase(navigationService);
    final homeController = HomeController(navigateToPageUseCase);

    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey, // Use global navigator key
      title: 'projek_uts',
      debugShowCheckedModeBanner: false,
      initialRoute: '/maps',
      routes: {
        '/maps': (context) => MapsPage(homeController),
        '/deskripsi': (context) => DeskripsiPage(homeController),
      },
    );
  }
}
