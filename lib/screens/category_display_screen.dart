import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/category_list_tile.dart';
import './edit_category_screen.dart';

class CategoryDisplayScreen extends StatelessWidget {
  static const routeName = "/categories";
  const CategoryDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditCategoryScreen.routeName,
          );
        },
        tooltip: "Add New Category",
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Categories",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("categories").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return CategoryListTile(
                  title: snapshot.data!.docs[index].get("name"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return EditCategoryScreen(
                            id: snapshot.data!.docs[index].id,
                            data: snapshot.data!.docs[index].data(),
                          );
                        },
                      ),
                    );
                  },
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
