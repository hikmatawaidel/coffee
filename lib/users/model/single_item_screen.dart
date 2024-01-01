import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleItemScreen extends StatefulWidget {
  final Map<String, dynamic>? item;
  final List<Map<String, dynamic>> favorites;

  SingleItemScreen({required this.item, required this.favorites});

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  bool isFavorite = false;
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    // Check if the current item is in favorites
    isFavorite = widget.favorites.contains(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    double itemPrice = double.tryParse(widget.item?['item_price'] ?? '') ?? 0.0;
    double totalPrice = itemPrice * quantity;

    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Image.network(
                    '${widget.item?['item_image'] ?? ''}',
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BEST COFFEE",
                        style: TextStyle(
                          color: Color(0xFF651E17),
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.item?['item_name'] ?? 'Item Name Not Available',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.minus,
                                      size: 18,
                                      color: Color(0xFF651E17),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.plus,
                                      size: 18,
                                      color: Color(0xFF651E17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$ ${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF651E17),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.item?['item_description'] ?? 'Description Not Available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Volume:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${widget.item?['item_volume'] ?? 'Volume Not Available'} ml",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // Handle adding to cart
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 50,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF651E17),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Toggle favorite status
                                    isFavorite = !isFavorite;

                                    // Add or remove from favorites accordingly
                                    if (isFavorite) {
                                      widget.favorites.add(widget.item!);
                                    } else {
                                      widget.favorites.remove(widget.item);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF651E17),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
