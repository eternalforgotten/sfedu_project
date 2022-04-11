import 'dart:async';
import 'dart:io';

import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/business_logic/dish_bloc/dish_bloc.dart';
import 'package:client_app/classes/dish_category.dart';
import 'package:client_app/main.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/main_menu_page/widgets/dish_card.dart';
import 'package:client_app/ui/main_menu_page/widgets/name_block.dart';
import 'package:client_app/ui/main_menu_page/widgets/titles_list.dart';
import 'package:client_app/ui/main_menu_page/widgets/upper_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List<DishCategory> _categories = [
    DishCategory(
        icon: FontAwesomeIcons.exclamation, categoryName: DishCategoryName.all),
    DishCategory(
        icon: FontAwesomeIcons.hamburger,
        categoryName: DishCategoryName.burgers),
    DishCategory(
        icon: Icons.soup_kitchen, categoryName: DishCategoryName.mainCourse),
    DishCategory(
        icon: Icons.food_bank, categoryName: DishCategoryName.secondCourse),
    DishCategory(
        icon: FontAwesomeIcons.coffee, categoryName: DishCategoryName.drinks),
    DishCategory(
        icon: FontAwesomeIcons.birthdayCake,
        categoryName: DishCategoryName.desserts),
  ];
  int _selectedIndex = 0;
  void _tapHandler(int index) {
    _selectedIndex = index;
    BlocProvider.of<DishBloc>(context)
        .add(ChangedCategoryEvent(DishCategoryName.values[index]));
  }

  StreamSubscription streamSubscription;

  @override
  void didChangeDependencies() {
    streamSubscription = FirebaseFirestore.instance
        .collection('dishes')
        .snapshots()
        .listen((event) {
      if (!FIRST) {
        BlocProvider.of<DishBloc>(context, listen: false).add(FetchEvent());
        BlocProvider.of<CartBloc>(context, listen: false)
            .add(CartChangedEvent());
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
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
                        BlocProvider.of<DishBloc>(context).add(FetchEvent());
                        _refreshController.refreshCompleted();
                      },
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            floating: true,
                            expandedHeight:
                                ResponsiveSize.responsiveHeight(270, context),
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
                                  SizedBox(
                                    height: ResponsiveSize.responsiveHeight(
                                        17, context),
                                  ),
                                  BlocBuilder<DishBloc, DishState>(
                                    buildWhen: (prev, curr) => curr is FetchState,
                                    builder: (context, state) {
                                      return TitlesList(
                                        currentIndex: _selectedIndex,
                                        itemTapped: _tapHandler,
                                        items: _categories,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<DishBloc, DishState>(
                            builder: (context, state) {
                              if (state is ErrorState) {
                                return SliverToBoxAdapter(
                                  child: Center(
                                    child: Text(
                                      state.message,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .fontFamily,
                                        fontSize: ResponsiveSize.responsiveHeight(
                                          15,
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is FetchLoadingState) {
                                return SliverToBoxAdapter(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: ResponsiveSize.responsiveHeight(20, context)),
                                    child: CircularProgressIndicator.adaptive(
                                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                    ),
                                  ),
                                );
                              } else if (state is FetchState) {
                                return SliverList(
                                  delegate: SliverChildListDelegate.fixed(
                                    state.dishes.length > 0
                                        ? state.dishes
                                            .map(
                                              (e) => Column(
                                                children: [
                                                  DishCard(
                                                    dish: e,
                                                  ),
                                                  SizedBox(
                                                    height: ResponsiveSize
                                                        .responsiveHeight(
                                                            16, context),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList()
                                        : [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: ResponsiveSize
                                                    .responsiveHeight(
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
                                                    fontSize: ResponsiveSize
                                                        .responsiveHeight(
                                                      18,
                                                      context,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                  ),
                                );
                              }
                              return SliverToBoxAdapter(
                                child: Center(
                                  child: Text('Что-то не так'),
                                ),
                              );
                            },
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
      ),
    );
  }
}
