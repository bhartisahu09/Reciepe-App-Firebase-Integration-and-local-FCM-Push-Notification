import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoryDataToFirestore() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('Category');
  for (final CategoryModel place in receipeCategory){
    final String id = DateTime.now().toIso8601String() + Random().nextInt(1000000).toString();
    //ref.doc("das");
    await ref.doc(id).set(place.toMap());
  }
}

class CategoryModel {
  String name;
  String image;

  CategoryModel({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}

final List<CategoryModel> receipeCategory = [
  CategoryModel(
    name: "All",
    image: "https://www.dmoose.com/cdn/shop/articles/Main_Image_22.jpg?v=1671272734",
  ),
  CategoryModel(
    name: "Vegetarian",
    image: "https://i.ytimg.com/vi/E-UZ2P_cApc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCYD19oErbDuVYLX4duLhdBWt7dOA",
  ),
  CategoryModel(
    name: "Non-Veg",
    image: "https://kj1bcdn.b-cdn.net/media/52716/490-4907881_non-veg-food-png-image-background-non-veg.png",
  ),
  CategoryModel(
    name: "Breakfast",
    image: "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_4:3/k%2FPhoto%2FSeries%2F2019-07-california-recipes%2Fquinoa-oatmeal%2FCalifornia-Quinoa-Oatmeal_022",
  ),
  CategoryModel(
    name: "Lunch",
    image: "https://s3-ap-south-1.amazonaws.com/betterbutterbucket-silver/chitra-sendhil1453210035569e39b33b9db.jpeg",
  ),
  CategoryModel(
    name: "Dinner",
    image: "https://i.pinimg.com/736x/04/cd/3b/04cd3ba6932c4c443a419c50af571f62.jpg",
  ),
  CategoryModel(
    name: "Snacks",
    image: "https://girijapaati.com/cdn/shop/collections/enh_classicribbon.jpg?v=1691556230",
  ),
  CategoryModel(
    name: "Dessert",
    image: "https://celebratingsweets.com/wp-content/uploads/2025/07/Oatmeal-Chocolate-Chip-Bars-1-4.jpg",
  ),
];