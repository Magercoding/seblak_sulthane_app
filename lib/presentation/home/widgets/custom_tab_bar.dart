import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/local_product/local_product_bloc.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;
  final int initialTabIndex;
  final Function(int)? onTap; // Added onTap callback

  const CustomTabBar({
    Key? key,
    required this.tabTitles,
    required this.tabViews,
    this.initialTabIndex = 0,
    this.onTap, // Optional callback for tab selection
  })  : assert(tabTitles.length == tabViews.length,
            'Tab titles and views count must match'),
        super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    // Listen for tab changes and invoke callback
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTap?.call(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the controller if the initial tab index changes
    if (widget.initialTabIndex != oldWidget.initialTabIndex) {
      _tabController.index = widget.initialTabIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelColor: AppColors.grey,
          indicatorColor: AppColors.primary,
          tabs: widget.tabTitles
              .map((title) => Tab(
                    text: title,
                  ))
              .toList(),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          child: IndexedStack(
            index: _tabController.index,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
