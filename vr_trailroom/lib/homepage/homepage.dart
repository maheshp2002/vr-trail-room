import 'package:flutter/material.dart';
import 'package:vr_trailroom/arScreen/arScreen.dart';

import '../clothingItem/clothingItem.dart';

class HomePage extends StatelessWidget {
  final List<ClothingItem> clothingItems = [
    ClothingItem(
      name: 'Shirt',
      imageUrl: 'assets/images/offer-10.jpg', // Provide actual image paths
    ),
    ClothingItem(
      name: 'Dress',
      imageUrl: 'assets/images/offer-11.jpg',
    ),
    // Add more clothing items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Clothing App'),
      ),
      body: GridView.builder(
        itemCount: clothingItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ARScreen()),
              );
            },
            child: GridTile(
              child: Image.asset(
                clothingItems[index].imageUrl,
                fit: BoxFit.cover,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  clothingItems[index].name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
