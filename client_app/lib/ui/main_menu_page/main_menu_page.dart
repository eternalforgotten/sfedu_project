import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/classes/dish_category.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/main_menu_page/widgets/dish_card.dart';
import 'package:client_app/ui/main_menu_page/widgets/name_block.dart';
import 'package:client_app/ui/main_menu_page/widgets/search.dart';
import 'package:client_app/ui/main_menu_page/widgets/titles_list.dart';
import 'package:client_app/ui/main_menu_page/widgets/upper_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List<DishCategory> _categories = [
    DishCategory(icon: FontAwesomeIcons.exclamation, name: "Новинки"),
    DishCategory(icon: FontAwesomeIcons.hamburger, name: "Гамбургеры"),
    DishCategory(icon: FontAwesomeIcons.pepperHot, name: "Острое"),
    DishCategory(icon: FontAwesomeIcons.candyCane, name: "Десерты"),
    DishCategory(icon: FontAwesomeIcons.child, name: "Детское меню"),
    DishCategory(icon: FontAwesomeIcons.coffee, name: "Напитки"),
    DishCategory(icon: FontAwesomeIcons.fish, name: "Рыба"),
  ];

  List<Dish> _dishes = [
    Dish(
      id: 0,
      description: "Пальчики оближешь!",
      name: "Бургер",
      price: "120",
      subName: "Сочный и вкусный",
      image: CachedNetworkImageProvider(
        "https://raketaburger.ru/wp-content/uploads/2019/09/-%D1%80%D0%B0%D0%BA%D0%B5%D1%82%D0%B0-min-960x600.jpg",
      ),
    ),
    Dish(
      id: 1,
      description: "Как будто из Италии.",
      name: "Спагетти",
      price: "120",
      subName: "Карбонара",
      image: CachedNetworkImageProvider(
        "https://static.1000.menu/img/content/37027/spagetti-s-tushenkoi_1564024332_1_max.jpg",
      ),
    ),
    Dish(
      id: 2,
      description: "Лучший выбор из горячих блюд.",
      name: "Сырный суп",
      price: "120",
      subName: "По-французски",
      image: CachedNetworkImageProvider(
        "https://s1.eda.ru/StaticContent/Photos/120131083619/170816150250/p_O.jpg",
      ),
    ),
    Dish(
      id: 3,
      name: "Цезарь",
      description: "Куда же без цезаря.",
      price: "120",
      subName: "С курицей",
      image: CachedNetworkImageProvider(
        "https://static.1000.menu/img/content-v2/79/77/1336/salat-cezar-s-syrom-pomidorami-kuricei-i-suxarikami_1617622037_14_max.jpg",
      ),
    ),
    Dish(
      id: 4,
      name: "Капучино",
      description: "Заряд бодрости на целый день.",
      price: "120",
      subName: "Со сливками",
      image: CachedNetworkImageProvider(
        "https://www.nestleprofessional.ru/data/uploads/article_block/image/999/5f71edfe53cb4.jpg",
      ),
    ),
  ];
  int _selectedIndex = 0;
  void _tapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                UpperIcons(),
                Expanded(
                  child: SmartRefresher(
                    header: Platform.isAndroid
                        ? MaterialClassicHeader()
                        : ClassicHeader(
                            refreshingIcon: CupertinoActivityIndicator(),
                            refreshingText: '',
                            releaseIcon: CupertinoActivityIndicator(),
                            releaseText: '',
                            completeIcon: CupertinoActivityIndicator(),
                            completeText: '',
                            idleIcon: null,
                            idleText: '',
                          ),
                    controller: _refreshController,
                    onRefresh: () {
                      _refreshController.refreshCompleted();
                    },
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          floating: true,
                          expandedHeight:
                              ResponsiveSize.responsiveHeight(315, context),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Column(
                              children: [
                                SizedBox(
                                  height: ResponsiveSize.responsiveHeight(
                                      25, context),
                                ),
                                const NameBlock(),
                                SizedBox(
                                  height: ResponsiveSize.responsiveHeight(
                                      33, context),
                                ),
                                const Search(),
                                SizedBox(
                                  height: ResponsiveSize.responsiveHeight(
                                      17, context),
                                ),
                                TitlesList(
                                  currentIndex: _selectedIndex,
                                  itemTapped: _tapHandler,
                                  items: _categories,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            _dishes.length > 0
                                ? _dishes
                                    .map(
                                      (e) => Column(
                                        children: [
                                          DishCard(
                                            dish: e,
                                          ),
                                          SizedBox(
                                            height:
                                                ResponsiveSize.responsiveHeight(
                                                    16, context),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: ResponsiveSize.responsiveHeight(
                                            50, context),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Ничего не найдено",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .fontFamily,
                                            fontSize:
                                                ResponsiveSize.responsiveHeight(
                                              18,
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                          ),
                        ),
                      ],
                    ),
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
