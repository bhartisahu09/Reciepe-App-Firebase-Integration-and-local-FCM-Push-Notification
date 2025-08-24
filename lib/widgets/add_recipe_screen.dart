// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/recipe_model.dart';
// import '../provider/recipe_provider.dart';

// class AddRecipeScreen extends StatefulWidget {
//   final RecipeModel? recipeToEdit; // If not null, we're editing an existing recipe

//   const AddRecipeScreen({Key? key, this.recipeToEdit}) : super(key: key);

//   @override
//   State<AddRecipeScreen> createState() => _AddRecipeScreenState();
// }

// class _AddRecipeScreenState extends State<AddRecipeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _imageController = TextEditingController();
//   final TextEditingController _ingredientController = TextEditingController();
//   final TextEditingController _stepController = TextEditingController();
  
//   String _selectedCategory = 'Vegetarian';
//   List<String> _ingredients = [];
//   List<String> _steps = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // If editing an existing recipe, populate the form fields
//     if (widget.recipeToEdit != null) {
//       _nameController.text = widget.recipeToEdit!.name;
//       _imageController.text = widget.recipeToEdit!.image;
//       _ingredients = List.from(widget.recipeToEdit!.ingredients);
//       _steps = List.from(widget.recipeToEdit!.steps);
//       _selectedCategory = widget.recipeToEdit!.category;
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _imageController.dispose();
//     _ingredientController.dispose();
//     _stepController.dispose();
//     super.dispose();
//   }

//   void _addIngredient() {
//     if (_ingredientController.text.trim().isNotEmpty) {
//       setState(() {
//         _ingredients.add(_ingredientController.text.trim());
//         _ingredientController.clear();
//       });
//     }
//   }

//   void _removeIngredient(int index) {
//     setState(() {
//       _ingredients.removeAt(index);
//     });
//   }

//   void _addStep() {
//     if (_stepController.text.trim().isNotEmpty) {
//       setState(() {
//         _steps.add(_stepController.text.trim());
//         _stepController.clear();
//       });
//     }
//   }

//   void _removeStep(int index) {
//     setState(() {
//       _steps.removeAt(index);
//     });
//   }

//   Future<void> _saveRecipe() async {
//     if (_formKey.currentState!.validate()) {
//       if (_ingredients.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please add at least one ingredient')),
//         );
//         return;
//       }

//       if (_steps.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please add at least one step')),
//         );
//         return;
//       }

//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
        
//         final recipe = RecipeModel(
//           id: widget.recipeToEdit?.id ?? '', // If editing, use existing ID
//           name: _nameController.text.trim(),
//           image: _imageController.text.trim(),
//           ingredients: _ingredients,
//           steps: _steps,
//           category: _selectedCategory,
//           createdAt: widget.recipeToEdit?.createdAt ?? Timestamp.now(),
//         );

//         if (widget.recipeToEdit != null) {
//           // Update existing recipe
//           await recipeProvider.updateRecipe(widget.recipeToEdit!.id, recipe);
//         } else {
//           // Add new recipe
//           await recipeProvider.addRecipe(recipe);
//         }

//         if (mounted) {
//           Navigator.pop(context);
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error saving recipe: ${e.toString()}')),
//           );
//         }
//       } finally {
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.recipeToEdit != null ? 'Edit Recipe' : 'Add New Recipe',
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.orange[700],
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Recipe Name
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Recipe Name',
//                         hintText: 'Enter recipe name',
//                         prefixIcon: Icon(Icons.restaurant_menu),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter a recipe name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     // Recipe Image URL
//                     TextFormField(
//                       controller: _imageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Image URL',
//                         hintText: 'Enter image URL',
//                         prefixIcon: Icon(Icons.image),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter an image URL';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     // Category Dropdown
//                     Consumer<RecipeProvider>(
//                       builder: (context, recipeProvider, child) {
//                         // Get categories from app categories
//                         final appCategories = recipeProvider.appCategories;
//                         final categoryNames = appCategories.isEmpty
//                             ? ['Vegetarian'] // Default if no categories exist
//                             : appCategories.map((cat) => cat.name).toList();
                        
//                         // Ensure selected category is in the list
//                         if (!categoryNames.contains(_selectedCategory) && categoryNames.isNotEmpty) {
//                           _selectedCategory = categoryNames.first;
//                         }
                        
//                         return DropdownButtonFormField<String>(
//                           value: _selectedCategory,
//                           decoration: const InputDecoration(
//                             labelText: 'Category',
//                             prefixIcon: Icon(Icons.category),
//                           ),
//                           items: categoryNames.map((category) {
//                             return DropdownMenuItem(
//                               value: category,
//                               child: Text(category),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               setState(() {
//                                 _selectedCategory = value;
//                               });
//                             }
//                           },
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 24),

//                     // Ingredients Section
//                     const Text(
//                       'Ingredients',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _ingredientController,
//                             decoration: const InputDecoration(
//                               hintText: 'Add an ingredient',
//                               prefixIcon: Icon(Icons.shopping_cart),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.add_circle, color: Colors.orange),
//                           onPressed: _addIngredient,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     _ingredients.isEmpty
//                         ? const Text('No ingredients added yet')
//                         : ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: _ingredients.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 leading: const Icon(Icons.check_circle, color: Colors.green),
//                                 title: Text(_ingredients[index]),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () => _removeIngredient(index),
//                                 ),
//                               );
//                             },
//                           ),
//                     const SizedBox(height: 24),

//                     // Steps Section
//                     const Text(
//                       'Preparation Steps',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _stepController,
//                             decoration: const InputDecoration(
//                               hintText: 'Add a preparation step',
//                               prefixIcon: Icon(Icons.format_list_numbered),
//                             ),
//                             maxLines: 2,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.add_circle, color: Colors.orange),
//                           onPressed: _addStep,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     _steps.isEmpty
//                         ? const Text('No steps added yet')
//                         : ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: _steps.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundColor: Colors.orange[700],
//                                   child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
//                                 ),
//                                 title: Text(_steps[index]),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () => _removeStep(index),
//                                 ),
//                               );
//                             },
//                           ),
//                     const SizedBox(height: 32),

//                     // Save Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _saveRecipe,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange[700],
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           widget.recipeToEdit != null ? 'Update Recipe' : 'Add Recipe',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }