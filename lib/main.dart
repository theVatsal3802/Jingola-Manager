import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './screens/category_display_screen.dart';
import './screens/edit_category_screen.dart';
import './screens/new_order_screen.dart';
import './screens/menu_display_screen.dart';
import './screens/home_screen.dart';
import './screens/edit_menu_screen.dart';
import './screens/past_order_screen.dart';
import './config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jingola Manager',
      theme: theme(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          return const AuthScreen();
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        PastOrderScreen.routeName: (context) => const PastOrderScreen(),
        NewOrderScreen.routeName: (context) => const NewOrderScreen(),
        CategoryDisplayScreen.routeName: (context) =>
            const CategoryDisplayScreen(),
        EditCategoryScreen.routeName: (context) => const EditCategoryScreen(
              data: {},
              id: "",
            ),
        MenuDisplayScreen.routeName: (context) => const MenuDisplayScreen(),
        EditMenuScreen.routeName: (context) => const EditMenuScreen(
              id: "",
              data: {},
            ),
      },
    );
  }
}
