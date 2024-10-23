import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  String? _selectedCategory;
  File? _image;
  final picker = ImagePicker();

  Future<void> _addProduct(BuildContext context) async {
    String productName = _productNameController.text.trim();
    double? productPrice = double.tryParse(_productPriceController.text.trim());
    String productDescription = _productDescriptionController.text.trim();
    if (productName.isNotEmpty &&
        productPrice != null &&
        productDescription.isNotEmpty &&
        _selectedCategory != null &&
        _image != null) {
      try {
        String fileName = 'products/${_image!.path.split('/').last}';
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(_image!);
        String imageUrl = await storageRef.getDownloadURL();

        CollectionReference products =
            FirebaseFirestore.instance.collection('products');
        await products.add({
          'name': productName,
          'price': productPrice,
          'description': productDescription,
          'category': _selectedCategory,
          'imageUrl': imageUrl,
        });

        _productNameController.clear();
        _productPriceController.clear();
        _productDescriptionController.clear();
        setState(() => _image = null);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all the fields and upload an image')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Add Product', style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFFFF3B30), 
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _productNameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Color(0xFFFF3B30)), 
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF3B30)),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _productPriceController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Price (RS)',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Color(0xFFFF3B30)), 
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF3B30)),
              ),
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator(color: Color(0xFFFF3B30));
              List<DropdownMenuItem<String>> categoryItems = snapshot.data!.docs
                  .map((doc) => DropdownMenuItem<String>(
                        value: doc['name'],
                        child: Text(doc['name']),
                      ))
                  .toList();
              return DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text('Select Category', style: TextStyle(color: Colors.black)),
                onChanged: (value) => setState(() => _selectedCategory = value),
                items: categoryItems,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  labelStyle: TextStyle(color: Color(0xFFFF3B30)), 
                ),
              );
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _productDescriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Color(0xFFFF3B30)), 
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF3B30)),
              ),
            ),
          ),
          SizedBox(height: 20),
          _image != null
              ? Image.file(_image!)
              : ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Upload Image'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF3B30),
                    onPrimary: Colors.white,
                  ),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Add Product'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFF3B30), 
              onPrimary: Colors.white,
            ),
            onPressed: () => _addProduct(context),
          ),
        ],
      ),
    ),
  );
}


}
