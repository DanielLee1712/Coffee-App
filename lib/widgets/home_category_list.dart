import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/providers/home_main_provider.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (context, homeProvider, child) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeProvider.categories.length,
            itemBuilder: (context, index) {
              bool isSelected = homeProvider.selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  homeProvider.setSelectedCategoryIndex(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFB8860B)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    homeProvider.categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
