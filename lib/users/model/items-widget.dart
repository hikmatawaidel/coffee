import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'https://koki410.000webhostapp.com';

class ItemsWidget extends StatefulWidget {
  final int catId;
  final List<Map<String, dynamic>> items;
  final Function(int) updateItems;
  void Function(Map<String, dynamic>) onItemSelected;

  ItemsWidget({
    required Key key,
    required this.catId,
    required this.items,
    required this.updateItems,
    required this.onItemSelected, // Add this line
  }) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  bool _isLoading = true;
  void _handleItemSelected(Map<String, dynamic> selectedItem) {
    widget.onItemSelected(selectedItem);
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didUpdateWidget(covariant ItemsWidget oldWidget) {
    print("object");
    if (widget.catId != oldWidget.catId) {
      setState(() {
        _fetchData();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (145 / 220),
      children: [
        for (var item in widget.items) _buildItemContainer(item),
      ],
    );
  }

  Widget _buildItemContainer(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _handleItemSelected(item); // Pass the selected item to the callback
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Image.network(
                '${item['item_image']}',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['item_name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF651E17),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Best Coffee",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF651E17),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${item['item_price']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF651E17),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _fetchData() async {
    try {
      final url = Uri.parse('$_baseURL/getItems.php?cat_id=${widget.catId}');
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      widget.items.clear(); // Clear old items

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);

        for (var row in jsonResponse) {
          widget.items.add({
            'item_name': row['item_name'],
            'item_price': row['price'],
            'item_image': '$_baseURL/images/${row['image']}',
          });
        }

        setState(() {
          _isLoading = false;
        });

        // Update items in the home screen
        widget.updateItems(widget.catId);
      } else {
        _handleFetchError();
      }
    } catch (e) {
      _handleFetchError();
    }
  }

  void _handleFetchError() {
    setState(() {
      _isLoading = false;
      // Handle the error state here
    });
  }

}
