// lib/presentation/home/widgets/custom_tab_barV2.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/utils/sound_feedback.dart';
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
  // Row 1: 0=Semua, 1=Makanan, 2=Minuman (always has selection)
  int _selectedRow1Index = 0;
  // Row 2: -1=none selected, 0..N=selected index
  int _selectedRow2Index = -1;

  static const _priceFilters = [
    "500",
    "1000",
    "1500-2000",
    "2500",
    "3000-9000",
  ];

  static const _priceFilterLabels = [
    'Menu 500',
    'Menu 1000',
    'Menu 1500-2000',
    'Menu 2500',
    'Menu 3000-9000',
  ];

  @override
  void initState() {
    super.initState();
    _selectedRow1Index = 0;
    _selectedRow2Index = -1;
  }

  CategoryModel? _findCategory(String name) {
    try {
      return widget.categories.firstWhere(
        (c) => (c.name ?? '').toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Dispatch the correct filter event based on current selections
  void _dispatchFilter() {
    final bloc = context.read<LocalProductBloc>();

    // Determine category from row 1
    int? categoryId;
    if (_selectedRow1Index == 1) {
      categoryId = _findCategory('Makanan')?.id;
    } else if (_selectedRow1Index == 2) {
      categoryId = _findCategory('Minuman')?.id;
    }

    // Determine price range from row 2
    String? priceRange;
    if (_selectedRow2Index >= 0 &&
        _selectedRow2Index < _priceFilters.length) {
      priceRange = _priceFilters[_selectedRow2Index];
    }

    // Determine other category from row 2
    int? row2CategoryId;
    if (_selectedRow2Index >= _priceFilters.length) {
      final otherCategories = _getOtherCategories();
      final catIndex = _selectedRow2Index - _priceFilters.length;
      if (catIndex < otherCategories.length) {
        row2CategoryId = otherCategories[catIndex].id;
      }
    }

    // Row1=Semua, Row2=none → show all
    if (_selectedRow1Index == 0 && _selectedRow2Index == -1) {
      bloc.add(const LocalProductEvent.getLocalProduct());
    }
    // Row1=Semua, Row2=price → filter by price only
    else if (_selectedRow1Index == 0 && priceRange != null) {
      bloc.add(LocalProductEvent.filterByPriceRange(priceRange));
    }
    // Row1=Semua, Row2=other category → filter by that category
    else if (_selectedRow1Index == 0 && row2CategoryId != null) {
      bloc.add(LocalProductEvent.filterByCategory(row2CategoryId));
    }
    // Row1=Makanan/Minuman, Row2=none → filter by category only
    else if (categoryId != null && _selectedRow2Index == -1) {
      bloc.add(LocalProductEvent.filterByCategory(categoryId));
    }
    // Row1=Makanan/Minuman, Row2=price → combined filter
    else if (categoryId != null && priceRange != null) {
      bloc.add(LocalProductEvent.filterByCategoryAndPriceRange(
          categoryId, priceRange));
    }
    // Row1=Makanan/Minuman, Row2=other category → just use row2 category
    else if (categoryId != null && row2CategoryId != null) {
      bloc.add(LocalProductEvent.filterByCategory(row2CategoryId));
    }
    // Fallback
    else {
      bloc.add(const LocalProductEvent.getLocalProduct());
    }
  }

  List<CategoryModel> _getOtherCategories() {
    return widget.categories
        .where((c) =>
            (c.name ?? '').toLowerCase() != 'makanan' &&
            (c.name ?? '').toLowerCase() != 'minuman')
        .toList();
  }

  void _onRow1Tap(int index) {
    SoundFeedback.playSelectionSound();
    setState(() {
      _selectedRow1Index = index;
      // Reset row 2 when switching row 1
      _selectedRow2Index = -1;
    });
    _dispatchFilter();
  }

  void _onRow2Tap(int index) {
    SoundFeedback.playSelectionSound();
    setState(() {
      // Toggle: tap again to deselect
      if (_selectedRow2Index == index) {
        _selectedRow2Index = -1;
      } else {
        _selectedRow2Index = index;
      }
    });
    _dispatchFilter();
  }

  @override
  Widget build(BuildContext context) {
    final row1Tabs = ['Semua', 'Makanan', 'Minuman'];

    final otherCategories = _getOtherCategories();
    final row2Tabs = [
      ..._priceFilterLabels,
      ...otherCategories.map((e) => e.name ?? ''),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Semua, Makanan, Minuman
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            row1Tabs.length,
            (index) => GestureDetector(
              onTap: () => _onRow1Tap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: _selectedRow1Index == index
                      ? const Border(
                          bottom: BorderSide(
                            width: 3.0,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),
                child: Text(
                  row1Tabs[index],
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: _selectedRow1Index == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Row 2: Price filters + other categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              row2Tabs.length,
              (index) => GestureDetector(
                onTap: () => _onRow2Tap(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.only(right: 32),
                  decoration: BoxDecoration(
                    border: _selectedRow2Index == index
                        ? const Border(
                            bottom: BorderSide(
                              width: 3.0,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    row2Tabs[index],
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: _selectedRow2Index == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        // Tab Content - uses bloc state, not tabViews index
        Expanded(
          child: SingleChildScrollView(
            child: widget.tabViews.isNotEmpty
                ? widget.tabViews[0]
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
