import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderFormScreen extends StatefulWidget {
  final String productName;
  final String productImage;
  final double price;

  OrderFormScreen({
    required this.productName,
    required this.productImage,
    required this.price,
  });

  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}
class _OrderFormScreenState extends State<OrderFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

   Future<void> _placeOrder() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (_nameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _contactNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    Map<String, dynamic> newOrder = {
      'userId': user?.uid,
      'customerName': _nameController.text,
      'customerAddress': _addressController.text,
      'customerContactNumber': _contactNumberController.text,
      'productName': widget.productName,
      'productPrice': widget.price,
      'orderDate': DateTime.now(),
      'status': 'Processing'
    };

    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');

    try {
      DocumentReference documentRef = await orders.add(newOrder);

      _nameController.clear();
      _addressController.clear();
      _contactNumberController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Order placed successfully! Order ID: ${documentRef.id}')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while placing the order')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFD32F2F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(widget.productImage, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.8),
              ),
            ),
            SizedBox(height: 24),
            Text(
              widget.productName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'RS ${widget.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Color(0xFFD32F2F)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            buildTextField('Name', _nameController),
            SizedBox(height: 16),
            buildTextField('Address', _addressController),
            SizedBox(height: 16),
            buildTextField('Contact Number', _contactNumberController, TextInputType.phone),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFD32F2F),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: _placeOrder,
                child: Text('Place Order', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, [TextInputType? keyboardType]) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFFD32F2F)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD32F2F)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD32F2F)),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }
}
