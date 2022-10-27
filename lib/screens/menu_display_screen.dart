import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './edit_menu_screen.dart';
import '../widgets/menu_list_tile.dart';

class MenuDisplayScreen extends StatelessWidget {
  static const routeName = "/menu-display";
  const MenuDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Menu Items",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditMenuScreen.routeName);
          },
          tooltip: "Add New Menu Item",
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("menu").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                      "No Menu Items added yet!",
                      textScaleFactor: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return MenuListTile(
                        id: snapshot.data!.docs[index].id,
                        title: snapshot.data!.docs[index].get("name"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return EditMenuScreen(
                                  id: snapshot.data!.docs[index].id,
                                  data: snapshot.data!.docs[index].data(),
                                );
                              },
                            ),
                          );
                        },
                        instock: snapshot.data!.docs[index].get("in stock"),
                        leading: Image.network(
                          snapshot.data!.docs[index].get("imageUrl"),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
