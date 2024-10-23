import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoryScreen extends StatelessWidget {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> _deleteCategory(String categoryId, BuildContext context) async {
    final confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await categories.doc(categoryId).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete category: $e')),
        );
      }
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Delete Category', style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFFFF3B30), 
    ),
    body: StreamBuilder(
      stream: categories.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Color(0xFFFF3B30))));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Color(0xFFFF3B30))); 
        }

        return ListView.separated(
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => Divider(color: Color(0xFFFF3B30)),
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return Card( 
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 2, 
              child: ListTile(
                title: Text(
                  data['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF3B30)), 
                ),
                subtitle: Text(data['description'], style: TextStyle(color: Color(0xFFFF3B30))), 
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline, color: Color(0xFFFF3B30)), 
                  onPressed: () => _deleteCategory(doc.id, context),
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
