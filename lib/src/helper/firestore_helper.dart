import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/src/models/food.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addFoodToFirestore(Food food) async {
    try {
      await firebaseFirestore
          .collection('Foods')
          .doc(food.id)
          .set(food.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteFood(String id) async {
    try {
      await firebaseFirestore.collection('Foods').doc(id).delete();
    } on Exception catch (e) {
      print(e);
    }
  }

  editFood(String id, String name, String content) async {
    try {
      await firebaseFirestore
          .collection('Foods')
          .doc(id)
          .update({'name': name, 'content': content});
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<Food> getfoodFromFirestore(String id) async {
    DocumentSnapshot<dynamic> documentSnapshot =
        await firebaseFirestore.collection('Foods').doc(id).get();

    return Food.fromMap(documentSnapshot.data());
  }

  Future<List<Food>> getAllFoodsFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Foods').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Food> foods = docs.map((e) => Food.fromMap(e.data())).toList();

    return foods;
  }
}
