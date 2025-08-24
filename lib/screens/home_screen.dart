import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/receipe_items.dart';
import 'package:recipe_app/screens/see_all_items.dart';
import 'package:recipe_app/services/notification_service.dart';
import '../provider/recipe_provider.dart';
import 'recipe_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = '';
  List<Map<String, dynamic>> receipeCategory = [];
  List<Map<String, dynamic>> recipes = [];
  bool isLoading = true;
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<Map<String, dynamic>> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    NotificationService.getInitialMessage(context);

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.trim().toLowerCase();
        filterRecipesBySearch();
      });
    });
  }

  //Category
  Future<void> fetchData() async {
    await fetchCategory();
    if (receipeCategory.isNotEmpty) {
      category = receipeCategory[0]['name'];
      await filterProductByCategory(category);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchCategory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("Category").get();
      setState(() {
        receipeCategory = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> filterProductByCategory(String selectedCategory) async {
    setState(() {
      isLoading = true;
    });
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("myAppCollection")
          .where("category", isEqualTo: selectedCategory)
          .get();
      setState(() {
        category = selectedCategory;
        recipes = snapshot.docs.map((doc) => doc.data()).toList();
        filterRecipesBySearch();
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterRecipesBySearch() {
    if (searchQuery.isEmpty) {
      filteredRecipes = recipes;
    } else {
      filteredRecipes = recipes.where((recipe) {
        final name = recipe['name']?.toLowerCase() ?? '';
        return name.contains(searchQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                //'Food Mood',
                'Delicious- Quick & Easy Recipes',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, recipeProvider, child) {
          if (recipeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange[700]!,
                        const Color.fromARGB(255, 251, 122, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Search item
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search recipes...',
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      //const SizedBox(height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Sliding Banner
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.easeInOut,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    viewportFraction: 0.9,
                  ),
                  items: [
                    'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
                    'https://images.unsplash.com/photo-1498837167922-ddd27525d352',
                    'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327'
                  ].map((imageUrl) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(imageUrl, fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 12,
                            left: 12,
                            child: Text(
                              'Delicious Recipes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5,
                                    color: Colors.black54,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                //Category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(children: [
                        Text('Category',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF666666))),
                        Spacer(),
                        Text("See All",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF999999))),
                        Icon(Icons.keyboard_arrow_right,
                            color: Color(0xFF999999))
                      ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              receipeCategory.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                    onTap: () {
                                      filterProductByCategory(
                                          receipeCategory[index]['name']);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        //color: Colors.orange[700],
                                        border: Border.all(
                                            // width: category ==
                                            //         receipeCategory[index]['name']
                                            //     ? 2
                                            //     : 1,
                                            // color: category ==
                                            //         receipeCategory[index]['name']
                                            //     ? Colors.white
                                            //     : Colors.orange[700] ??
                                            //         Colors.orange
                                            color: Colors.white),
                                      ),
                                      child: Column(children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.orange[700],
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      receipeCategory[index]
                                                          ['image']))),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          receipeCategory[index]['name'],
                                          style: TextStyle(
                                              fontWeight: category ==
                                                      receipeCategory[index]
                                                          ['name']
                                                  ? FontWeight.bold
                                                  : FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ]),
                                    )),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                // Recipe
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Row(children: [
                        const Text('Category',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF666666))),
                        const Spacer(),
                        GestureDetector(
                          // onTap: () async {
                          //   await recipeProvider.showRecipeNotification();
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SeeAllItems()),
                          //   );
                          // },
                          onTap: () async {
                            if (!kIsWeb &&
                                (Platform.isAndroid || Platform.isIOS)) {
                              await recipeProvider.showRecipeNotification();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SeeAllItems()),
                            );
                          },
                          child: const Text("See All",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999))),
                        ),
                        const Icon(Icons.keyboard_arrow_right,
                            color: Color(0xFF999999))
                      ]),
                    ),
                  ],
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    // : recipes.isEmpty
                    : filteredRecipes.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Icons.search_off,
                                      size: 64, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text('No recipes available in this category',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey)),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15),
                              // itemCount: recipes.length,
                              itemCount: filteredRecipes.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeDetailScreen(
                                                    recipes: recipes[index])),
                                      );
                                    },
                                    // child: ReceipeItems(recipe: recipes[index]),
                                    child: ReceipeItems(
                                        recipe: filteredRecipes[index]),
                                  ),
                                );
                              },
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
