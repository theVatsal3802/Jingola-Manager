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
}
