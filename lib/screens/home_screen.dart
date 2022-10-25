import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './menu_display_screen.dart';
import './auth_screen.dart';
import '../widgets/home_list_tile.dart';
import './new_order_screen.dart';
import './past_order_screen.dart';
import './category_display_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Welcome",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then(
                (_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthScreen.routeName,
                    (route) => false,
                  );
                },
              );
            },
            child: Text(
              "Logout",
              textScaleFactor: 1,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: [
            HomeListTile(
              title: "Edit Categories",
              onTap: () {
                Navigator.of(context)
                    .pushNamed(CategoryDisplayScreen.routeName);
              },
              leading: const Icon(
                Icons.category,
                size: 48,
              ),
            ),
            HomeListTile(
              title: "Edit Menu",
              onTap: () {
                Navigator.of(context).pushNamed(MenuDisplayScreen.routeName);
              },
              leading: const Icon(
                Icons.menu_book,
                size: 48,
              ),
            ),
            HomeListTile(
              title: "Check New Orders",
              onTap: () {
                Navigator.of(context).pushNamed(NewOrderScreen.routeName);
              },
              leading: const Icon(
                Icons.fiber_new,
                size: 48,
              ),
            ),
            HomeListTile(
              title: "Check Completed Orders",
              onTap: () {
                Navigator.of(context).pushNamed(PastOrderScreen.routeName);
              },
              leading: const Icon(
                Icons.check_circle,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
