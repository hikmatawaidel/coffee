import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final TabController tabController;

  CustomTabBar({required this.categories, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              tabController.animateTo(index);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: tabController.index == index
                        ? Color(0xFF651E17)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                categories[index]['name'].toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: tabController.index == index
                      ? Color(0xFF651E17)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
