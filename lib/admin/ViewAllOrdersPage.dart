import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unlimited_shopping/admin/OrderDetailScreen.dart';

class ViewAllOrdersPage extends StatefulWidget {
  @override
  _ViewAllOrdersPageState createState() => _ViewAllOrdersPageState();
}

class _ViewAllOrdersPageState extends State<ViewAllOrdersPage> {
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
        backgroundColor: Color(0xFFFF3B30), 
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.white, 
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectedStatus,
              hint: Text('Filter by Status'),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Color(0xFFFF3B30)),
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
              items: <String>[
                'Pending',
                'Processing',
                'Shipped',
                'Delivered',
                'Cancelled'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: selectedStatus == null
                  ? FirebaseFirestore.instance.collection('orders').snapshots()
                  : FirebaseFirestore.instance
                      .collection('orders')
                      .where('status', isEqualTo: selectedStatus)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Color(0xFFFF3B30)));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Color(0xFFFF3B30))));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No orders found', style: TextStyle(color: Color(0xFFFF3B30))));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var order = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    var orderId = snapshot.data!.docs[index].id;

                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(orderId: orderId),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['productName'] ?? 'No Product Name',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF3B30)),
                              ),
                              SizedBox(height: 8),
                              Text('Name: ${order['customerName']}', style: TextStyle(color: Color(0xFFFF3B30))),
                              Text('Address: ${order['customerAddress']}', style: TextStyle(color: Color(0xFFFF3B30))),
                              Text('Status: ${order['status'] ?? 'Pending'}', style: TextStyle(color: Color(0xFFFF3B30))),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
