import 'package:cloud_firestore/cloud_firestore.dart';

class OtherFunctions {
  static Future<void> updateCategory(String id, String imageUrl) async {
    await FirebaseFirestore.instance.collection("categories").doc(id).update(
      {
        "imageUrl": imageUrl,
      },
    );
  }

  static Future<void> addCategory(String name, String imageUrl) async {
    await FirebaseFirestore.instance.collection("categories").add(
      {
        "name": name,
        "imageUrl": imageUrl,
      },
    );
  }

  static Future<void> deleteCategory(String id, String name) async {
    final docs = await FirebaseFirestore.instance
        .collection("menu")
        .where("category", isEqualTo: name)
        .get();
    List<String> ids = [];
    for (var element in docs.docs) {
      ids.add(element.id);
    }
    for (var i = 0; i < ids.length; i++) {
      await FirebaseFirestore.instance.collection("menu").doc(ids[i]).delete();
    }
    await FirebaseFirestore.instance.collection("categories").doc(id).delete();
  }

  static Future<void> updateMenuItem({
    required String id,
    required String imageUrl,
    required String description,
    required double price,
  }) async {
    await FirebaseFirestore.instance.collection("menu").doc(id).update(
      {
        "imageUrl": imageUrl,
        "description": description,
        "price": price.toStringAsFixed(2),
      },
    );
  }

  static Future<void> addMenuItem({
    required String name,
    required String imageUrl,
    required String category,
    required String description,
    required double price,
    required bool isVeg,
  }) async {
    await FirebaseFirestore.instance.collection("menu").add(
      {
        "name": name,
        "imageUrl": imageUrl,
        "category": category,
        "description": description,
        "price": price.toStringAsFixed(2),
        "isVeg": isVeg,
      },
    );
  }

  static Future<void> deleteMenuItem(String id) async {
    await FirebaseFirestore.instance.collection("menu").doc(id).delete();
  }
}
