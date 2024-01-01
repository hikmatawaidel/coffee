import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';

class HomeBottomBar extends StatelessWidget {
  final VoidCallback onFavoritePressed;

  HomeBottomBar({
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, color: Color(0xFF651E17), size: 35),
          IconButton(
            onPressed: onFavoritePressed,
            icon: Icon(Icons.favorite_outline, color: Colors.grey, size: 35),
          ),
          Icon(Icons.shopping_cart, color: Colors.grey, size: 35),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(Icons.person, color: Colors.grey, size: 35),
          ),
        ],
      ),
    );
  }
}
