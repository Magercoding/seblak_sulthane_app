// lib/presentation/home/widgets/custom_tab_barV2.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/local_product/local_product_bloc.dart';

class CustomTabBarV2 extends StatefulWidget {
  final List<CategoryModel> categories;
  final int initialTabIndex;
  final List<Widget> tabViews;

  const CustomTabBarV2({
    super.key,
    required this.categories,
    required this.initialTabIndex,
    required this.tabViews,
  });

  @override
  State<CustomTabBarV2> createState() => _CustomTabBarV2State();
}

class _CustomTabBarV2State extends State<CustomTabBarV2> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    // New order: All → Price Filters → Categories
    final allTabs = [
      'Semua',
      'Menu 500',
      'Menu 1000',
      'Menu 1500-2000',
      'Menu 2500',
      'Menu 3000-9000',
      ...widget.categories.map((e) => e.name ?? ''),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              allTabs.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });

                  // Handle "Semua" tab
                  if (index == 0) {
                    context
                        .read<LocalProductBloc>()
                        .add(const LocalProductEvent.getLocalProduct());
                  }
                  // Handle price filters (now indices 1-5)
                  else if (index <= 5) {
                    final priceFilters = [
                      "500",
                      "1000",
                      "1500-2000",
                      "2500",
                      "3000-9000",
                    ];
                    context.read<LocalProductBloc>().add(
                        LocalProductEvent.filterByPriceRange(
                            priceFilters[index - 1]));
                  }
                  // Handle categories (indices 6 and above)
                  else {
                    final categoryIndex =
                        index - 6; // Subtract price filter tabs
                    final categoryId = widget.categories[categoryIndex].id;
                    context
                        .read<LocalProductBloc>()
                        .add(LocalProductEvent.filterByCategory(categoryId));
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
                    allTabs[index],
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
