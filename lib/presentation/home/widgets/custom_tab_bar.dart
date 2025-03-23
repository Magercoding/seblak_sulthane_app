import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/local_product/local_product_bloc.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final int initialTabIndex;
  final List<Widget> tabViews;

  const CustomTabBar({
    super.key,
    required this.tabTitles,
    required this.initialTabIndex,
    required this.tabViews,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.tabTitles.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });

                  if (widget.tabTitles[index] == "Menu 500") {
                    context
                        .read<LocalProductBloc>()
                        .add(const LocalProductEvent.filterByPriceRange("500"));
                  } else if (widget.tabTitles[index] == "Menu 1000") {
                    context.read<LocalProductBloc>().add(
                        const LocalProductEvent.filterByPriceRange("1000"));
                  } else if (widget.tabTitles[index] == "Menu 1500-2000") {
                    context.read<LocalProductBloc>().add(
                        const LocalProductEvent.filterByPriceRange(
                            "1500-2000"));
                  } else if (widget.tabTitles[index] == "Menu 2500") {
                    context.read<LocalProductBloc>().add(
                        const LocalProductEvent.filterByPriceRange("2500"));
                  } else if (widget.tabTitles[index] == "Menu 3000-9000") {
                    context.read<LocalProductBloc>().add(
                        const LocalProductEvent.filterByPriceRange(
                            "3000-9000"));
                  } else {
                    context
                        .read<LocalProductBloc>()
                        .add(const LocalProductEvent.getLocalProduct());
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.only(right: 32),
                  decoration: BoxDecoration(
                    border: _selectedIndex == index
                        ? const Border(
                            bottom: BorderSide(
                              width: 3.0,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    widget.tabTitles[index],
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        widget.tabViews[_selectedIndex],
      ],
    );
  }
}
