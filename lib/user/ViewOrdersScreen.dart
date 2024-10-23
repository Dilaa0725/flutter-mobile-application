import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewOrdersScreen extends StatelessWidget {
    final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
      final User? user = FirebaseAuth.instance.currentUser;
   final usermail = _auth.currentUser;
    final String email = user?.email ?? 'Not logged in';
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFFF3B30), 
      ),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection('orders').where('userId', isEqualTo:  user?.uid) .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Color(0xFFFF3B30)));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Color(0xFFFF3B30))));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text('No orders found',
                    style: TextStyle(color: Color(0xFFFF3B30))));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Order ID: ${snapshot.data!.docs[index].id}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF3B30)),
                      ),
                      buildOrderDetailText(
                          'Product Name: ${orderData['productName']}'),
                      buildOrderDetailText(
                          'Price: RS${orderData['productPrice']}'),
                      buildOrderDetailText(
                          'Address: ${orderData['customerAddress']}'),
                      buildOrderDetailText(
                          'Contact: ${orderData['customerContactNumber']}'),
                      SizedBox(height: 10),
                      Text('Status: ${orderData['status']}',
                          style: TextStyle(color: Color(0xFFFF3B30))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xFFFF3B30)),
                            onPressed: () {
                         
                            },
                          ),
                          
                          
                        ],
                      ),
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

  Widget buildOrderDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54, 
        ),
      ),
    );
  }
}
