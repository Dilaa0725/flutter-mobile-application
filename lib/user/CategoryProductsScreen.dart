import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unlimited_shopping/user/OrderFormScreen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  CategoryProductsScreen({required this.categoryName});

@override
Widget build(BuildContext context) {
  CollectionReference products = FirebaseFirestore.instance.collection('products');

return Scaffold(
  appBar: AppBar(
    title: Text(categoryName),
    backgroundColor: Color(0xFFFF3B30), 
  ),
  body: StreamBuilder<QuerySnapshot>(
    stream: products.where('category', isEqualTo: categoryName).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No products found in this category'));
      }

      return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, 
        ),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          var product = snapshot.data!.docs[index].data() as Map<String, dynamic>;
          return Card(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
           
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                      child: Image.network(
                        product['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            color: Color(0xFFFF3B30), 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RS ${product['price']}',
                          style: TextStyle(
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF3B30), 
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderFormScreen(
                              productName: product['name'],
                              productImage: product['imageUrl'],
                              price: product['price'],
                            ),
                          ),
                        );
                      },
                      child: Text('Buy Now'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  ),
);

}
}