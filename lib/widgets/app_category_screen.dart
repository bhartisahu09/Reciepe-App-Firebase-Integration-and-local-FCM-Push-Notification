// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/recipe_provider.dart';
// import '../models/app_category_model.dart';

// class AppCategoryScreen extends StatefulWidget {
//   const AppCategoryScreen({Key? key}) : super(key: key);

//   @override
//   State<AppCategoryScreen> createState() => _AppCategoryScreenState();
// }

// class _AppCategoryScreenState extends State<AppCategoryScreen> {
//   final TextEditingController _categoryController = TextEditingController();
//   String? _editingCategoryId;

//   @override
//   void dispose() {
//     _categoryController.dispose();
//     super.dispose();
//   }

//   void _showAddCategoryDialog(BuildContext context, [AppCategoryModel? category]) {
//     if (category != null) {
//       _editingCategoryId = category.id;
//       _categoryController.text = category.name;
//     } else {
//       _editingCategoryId = null;
//       _categoryController.text = '';
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(category == null ? 'Add Category' : 'Edit Category'),
//         content: TextField(
//           controller: _categoryController,
//           decoration: const InputDecoration(
//             labelText: 'Category Name',
//             hintText: 'Enter category name',
//           ),
//           autofocus: true,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               final provider = Provider.of<RecipeProvider>(context, listen: false);
//               final name = _categoryController.text.trim();
              
//               if (name.isNotEmpty) {
//                 if (_editingCategoryId == null) {
//                   // Add new category
//                   provider.addAppCategory(name);
//                 } else {
//                   // Update existing category
//                   provider.updateAppCategory(_editingCategoryId!, name);
//                 }
//               }
              
//               Navigator.pop(context);
//             },
//             child: Text(category == null ? 'Add' : 'Update'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _confirmDeleteCategory(BuildContext context, AppCategoryModel category) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Category'),
//         content: Text('Are you sure you want to delete "${category.name}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Provider.of<RecipeProvider>(context, listen: false)
//                   .deleteAppCategory(category.id);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('"${category.name}" deleted')),
//               );
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Manage Categories',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.orange[700],
//         elevation: 0,
//       ),
//       body: Consumer<RecipeProvider>(builder: (context, recipeProvider, child) {
//         if (recipeProvider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final categories = recipeProvider.appCategories;

//         return categories.isEmpty
//             ? const Center(
//                 child: Text(
//                   'No categories found',
//                   style: TextStyle(fontSize: 18, color: Colors.grey),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return ListTile(
//                     title: Text(category.name),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () => _showAddCategoryDialog(context, category),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _confirmDeleteCategory(context, category),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//       }),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange[700],
//         onPressed: () => _showAddCategoryDialog(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }