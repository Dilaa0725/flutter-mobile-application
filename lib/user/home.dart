import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unlimited_shopping/user/CategoryProductsScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
@override
  Widget build(BuildContext context) {



  final List<String> imageList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtun60IM0yI5dPtzFqtGUqwuTFo7EHz1YezQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKShUcGmUjwKeLnT947Rmy4hWhbFhZqe08g0scezCMrNQsI6PNmBAotAsdXosDDmn7dvU&usqp=CAU',
    'https://ae01.alicdn.com/kf/H1722c3d7491f48c7ba074c0362a567aem.jpg_640x640Q90.jpg_.webp',
  ];


    return Scaffold(
      backgroundColor: Color(0xFFFF3B30), 
      appBar: AppBar(
        title: Text('Unlimited Shopping', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFD32F2F),
        actions: <Widget>[
    
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
            ),
            items: imageList.map((image) => Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: <Widget>[
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      bottom: 20.0,
                      left: 20.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        color: Colors.redAccent,
                        child: Text(
                          'Upto 70% Off',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.0,
                      left: 20.0,
                      child: Text(
                        'Fresh Winter Delights\nOffer to beat the cold',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )).toList(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No categories found'));
                }
                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var category = snapshot.data!.docs[index];
                    var data = category.data() as Map<String, dynamic>;
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                           
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsScreen(categoryName: data['name']),
                    ),
                  );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                           
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFD32F2F),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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

