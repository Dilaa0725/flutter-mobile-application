import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  OrderDetailScreen({required this.orderId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? currentStatus;
  final List<String> statuses = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled'
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentStatus();
  }

  void _fetchCurrentStatus() async {
    DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get();
    if (orderSnapshot.exists) {
      setState(() {
        currentStatus = orderSnapshot['status'] as String? ?? statuses.first;
      });
    }
  }

  void _updateStatus(String? newStatus) async {
    if (newStatus == null || newStatus == currentStatus) return;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .update({
      'status': newStatus,
    });
    setState(() {
      currentStatus = newStatus;
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Update Order Status', style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFFFF3B30), 
    ),
    body: currentStatus == null
        ? Center(child: CircularProgressIndicator(color: Color(0xFFFF3B30))) 
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select the new status for the order:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF3B30)), 
                ),
                SizedBox(height: 20), 
                DropdownButton<String>(
                  value: currentStatus,
                  onChanged: _updateStatus, 
                  items: statuses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Color(0xFFFF3B30), fontSize: 16), 
                  underline: Container(
                    height: 2,
                    color: Color(0xFFFF3B30), 
                  ),
                  isExpanded: true, 
                  iconEnabledColor: Color(0xFFFF3B30), 
                ),
              ],
            ),
          ),
  );
}

}
