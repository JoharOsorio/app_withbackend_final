import 'package:flutter/material.dart';
import 'package:app_withbackend_final/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'list_product': (BuildContext context) => const ListProductScreen(),
    'edit_product': (BuildContext context) => const EditProductScreen(),
    'list_category': (BuildContext context) => const ListCategoryScreen(),
    'edit_category': (BuildContext context) => const EditCategoryScreen(),
    'list_provider': (BuildContext context) => const ListProviderScreen(),
    'edit_provider': (BuildContext context) => const EditProviderScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
