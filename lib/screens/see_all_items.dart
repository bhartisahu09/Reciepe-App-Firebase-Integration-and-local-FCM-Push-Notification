import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/receipe_items.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

class SeeAllItems extends StatefulWidget {
  const SeeAllItems({super.key});

  @override
  State<SeeAllItems> createState() => _SeeAllItemsState();
}

class _SeeAllItemsState extends State<SeeAllItems> {
  List<Map<String, dynamic>> receipeCategory = [];
  List<Map<String, dynamic>> filterItem = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllItems();
  }

  //receipes
  Future<void> fetchAllItems() async {
    setState(() {
      isLoading = true;
    });
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("myAppCollection").get();
      setState(() {
        receipeCategory = snapshot.docs.map((doc) => doc.data()).toList();
        filterItem = receipeCategory;
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //method filterItems based on search Query
  void filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        filterItem = receipeCategory;
      });
    } else {
      setState(() {
        filterItem = receipeCategory.where((item) {
          return item['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        backgroundColor: Colors.orange[700],
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          onChanged: filterItems,
                          decoration: InputDecoration(
                            hintText: 'Search recipes...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),                      
                      SizedBox(
                        height: 720,
                        width: double.maxFinite,
                        child: GridView.builder(
                          padding: const EdgeInsets.only(left:2),
                          itemCount: filterItem.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            final recipe = filterItem[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeDetailScreen(recipes: recipe),
                                    ),
                                  );
                                },
                                child: ReceipeItems(recipe: recipe),
                              );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
