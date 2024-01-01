import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  FavoriteScreen({required this.favorites, required this.onRemoveFavorite});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: widget.favorites.isEmpty
          ? Center(
        child: Text(
          'No favorite items yet.',
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final favoriteItem = widget.favorites[index];
          return ListTile(
            title: Text(favoriteItem['item_name'] ?? ''),
            subtitle: Text('\$${favoriteItem['item_price'] ?? ''}'),
            leading: Image.network(
              '${favoriteItem['item_image'] ?? ''}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                // Call the onRemoveFavorite callback when the heart icon is pressed
                widget.onRemoveFavorite(favoriteItem);

                // Trigger a rebuild of the FavoriteScreen
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
