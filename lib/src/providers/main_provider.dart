import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_app/src/helper/firestorage_helper.dart';
import 'package:food_app/src/helper/firestore_helper.dart';
import 'package:food_app/src/models/food.dart';

import 'package:image_picker/image_picker.dart';

class mainProviders extends ChangeNotifier {
  late List<Food> foods;
  late String myId;
  mainProviders() {
    getAllFood();
  }

  getAllFood() async {
    foods = await FirestoreHelper.firestoreHelper.getAllFoodsFromFirestore();

    notifyListeners();
  }

  late Food food;
  getfood(String id) async {
    food = await FirestoreHelper.firestoreHelper.getfoodFromFirestore(id);
    getAllFood();
    notifyListeners();
  }

  deleteFood(String id) async {
    await FirestoreHelper.firestoreHelper.deleteFood(id);
    getAllFood();
    notifyListeners();
  }

  editFood(String id, String name, String content) async {
    await FirestoreHelper.firestoreHelper.editFood(id, name, content);
    getfood(id);
    getAllFood();
    notifyListeners();
  }

///////////////////////////////////////////////////
  ///upload Image
  File? file;
  selectFile() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile!.path);
    notifyListeners();
  }

  var random = new Random();
  addFood(String name, String content) async {
    String imageUrl =
        await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file!);
    Food food = Food(
        id: random.nextInt(1000000).toString() + "Food",
        name: name,
        image: imageUrl,
        content: content);
    await FirestoreHelper.firestoreHelper.addFoodToFirestore(food);
    getAllFood();
    notifyListeners();
  }
}
