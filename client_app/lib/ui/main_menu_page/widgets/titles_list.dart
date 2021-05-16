import 'package:client_app/classes/dish_category.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/main_menu_page/widgets/title_item.dart';
import 'package:flutter/material.dart';

class TitlesList extends StatelessWidget {
  final ValueChanged<int> itemTapped;
  final int currentIndex;
  final List<DishCategory> items;

  TitlesList({this.itemTapped, this.currentIndex, this.items});

  DishCategory get selectedItem =>
      currentIndex >= 0 && currentIndex < items.length
          ? items[currentIndex]
          : null;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: ResponsiveSize.responsiveHeight(60, context),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(
              width: ResponsiveSize.responsiveWidth(16, context),
            ),
            itemCount: items.length,
            itemBuilder: (_, ind) {
              var item = TitleItem(
                data: items[ind],
                isSelected: items[ind] == selectedItem,
                onTap: () {
                  var index = items.indexOf(items[ind]);
                  itemTapped(index);
                },
              );
              if (ind == 0) {
                return Container(
                  margin: EdgeInsets.only(
                    left: ResponsiveSize.responsiveWidth(20, context),
                  ),
                  child: item,
                );
              } else if (ind == items.length - 1) {
                return Container(
                  margin: EdgeInsets.only(
                    right: ResponsiveSize.responsiveWidth(20, context),
                  ),
                  child: item,
                );
              } else
                return item;
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: ResponsiveSize.responsiveHeight(8, context),
        ),
        Text(
          items[currentIndex].name,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
            fontSize: ResponsiveSize.responsiveHeight(16, context),
          ),
        )
      ],
    );
  }
}
