import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryScreen extends StatelessWidget {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();

  Future<void> _addCategoryToFirestore(BuildContext context) async {
    String categoryName = _categoryNameController.text.trim();
    String categoryDescription = _categoryDescriptionController.text.trim();
    if (categoryName.isNotEmpty && categoryDescription.isNotEmpty) {
      try {
        CollectionReference categories =
            FirebaseFirestore.instance.collection('categories');
        await categories.add({
          'name': categoryName,
          'description': categoryDescription,
        });
        _categoryNameController.clear();
        _categoryDescriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add category: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields')),
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Add Category', style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFFFF3B30), 
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _categoryNameController,
            decoration: InputDecoration(
              labelText: 'Category Name',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.category, color: Color(0xFFFF3B30)), 
            ),
          ),
          SizedBox(height: 24),
          TextFormField(
            controller: _categoryDescriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Category Description',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.description, color: Color(0xFFFF3B30)), 
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            child: Text('Add Category'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFF3B30), 
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () => _addCategoryToFirestore(context),
          ),
        ],
      ),
    ),
  );

}
}