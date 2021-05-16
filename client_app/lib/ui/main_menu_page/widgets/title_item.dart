import 'package:client_app/classes/dish_category.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  final DishCategory data;
  final bool isSelected;
  final VoidCallback onTap;

  TitleItem({this.data, this.isSelected, this.onTap});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          ResponsiveSize.responsiveHeight(15, context),
        ),
        height: ResponsiveSize.responsiveHeight(60, context),
        width: ResponsiveSize.responsiveHeight(60, context),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Color(0xFFF2F3F4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          data.icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
