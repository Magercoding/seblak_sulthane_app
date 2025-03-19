import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/discount_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/member_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/tax_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/pages/confirm_payment_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../dialog/service_dialog.dart';
import '../widgets/column_button.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/home_title.dart';
import '../widgets/order_menu.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final bool isTable;
  final TableModel? table;
  const HomePage({
    super.key,
    required this.isTable,
    this.table,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  bool isTakeaway = true; // State untuk menyimpan status pemesanan
  String searchQuery = ''; // Track search query
  int currentTabIndex = 0; // Track current tab index

  @override
  void initState() {
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());

    // Force dine in mode if this is a table order
    if (widget.isTable) {
      isTakeaway = false; // Set to Dine In if it's a table
    }

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onCategoryTap(int index) {
    setState(() {
      currentTabIndex = index;
      // Clear search when changing categories
      searchController.clear();
      searchQuery = '';
    });
  }

  // Filter products based on search query and current tab
  // This function uses dynamic typing to handle different product types
  List<dynamic> filterProducts(List products, int categoryIndex) {
    if (products.isEmpty) return [];

    // First filter by category if not "All" tab
    List filteredByCategory;

    if (categoryIndex == 0) {
      // "All" category - no filtering needed
      filteredByCategory = products;
    } else if (categoryIndex >= 1 && categoryIndex <= 3) {
      // Handle different category filtering based on product type
      filteredByCategory = products.where((product) {
        // Check if the product has a category property
        if (product.category == null) return false;

        // Use a safe way to check category - adapt to your actual model structure
        // Assuming category has some property/method to identify it
        if (categoryIndex == 1) {
          // Food category
          return product.category.toString().toLowerCase().contains('food') ||
              product.category.toString().toLowerCase().contains('makanan');
        } else if (categoryIndex == 2) {
          // Drink category
          return product.category.toString().toLowerCase().contains('drink') ||
              product.category.toString().toLowerCase().contains('minuman');
        } else {
          // Snack category
          return product.category.toString().toLowerCase().contains('snack');
        }
      }).toList();
    } else {
      filteredByCategory = products;
    }

    // Then filter by search query if it's not empty
    if (searchQuery.isEmpty) {
      return filteredByCategory;
    }

    // Search by product name, case insensitive
    return filteredByCategory
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            // Update search query and refresh UI
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTabBar(
                          tabTitles: const [
                            'Semua',
                            'Makanan',
                            'Minuman',
                            'Snack'
                          ],
                          initialTabIndex: currentTabIndex,
                          onTap: onCategoryTap,
                          tabViews: [
                            // All Products Tab (Index 0)
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }

                                      // Apply search filtering for all products
                                      final filteredProducts =
                                          filterProducts(products, 0);

                                      if (filteredProducts.isEmpty) {
                                        return searchQuery.isNotEmpty
                                            ? _buildNoSearchResults()
                                            : const Center(
                                                child: Text('No Items'));
                                      }

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredProducts.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: filteredProducts[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            // Food Products Tab (Index 1)
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }

                                      // Apply search filtering for food category
                                      final filteredProducts =
                                          filterProducts(products, 1);

                                      if (filteredProducts.isEmpty) {
                                        return searchQuery.isNotEmpty
                                            ? _buildNoSearchResults()
                                            : const _IsEmpty();
                                      }

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredProducts.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: filteredProducts[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            // Drink Products Tab (Index 2)
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }

                                      // Apply search filtering for drink category
                                      final filteredProducts =
                                          filterProducts(products, 2);

                                      if (filteredProducts.isEmpty) {
                                        return searchQuery.isNotEmpty
                                            ? _buildNoSearchResults()
                                            : const _IsEmpty();
                                      }

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredProducts.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: filteredProducts[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            // Snack Products Tab (Index 3)
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }

                                      // Apply search filtering for snack category
                                      final filteredProducts =
                                          filterProducts(products, 3);

                                      if (filteredProducts.isEmpty) {
                                        return searchQuery.isNotEmpty
                                            ? _buildNoSearchResults()
                                            : const _IsEmpty();
                                      }

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredProducts.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: filteredProducts[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Updated text for table orders
                          Text(
                            widget.isTable
                                ? 'Table ${widget.table?.tableNumber ?? ""} Order'
                                : 'Orders #1',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SpaceHeight(8.0),

                          // Add visual indicator for table orders
                          if (widget.isTable) ...[
                            // Table indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              margin: const EdgeInsets.only(bottom: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: Colors.green.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.table_restaurant,
                                      color: Colors.green),
                                  const SpaceWidth(8.0),
                                  Text(
                                    'Table Order: ${widget.table?.tableNumber ?? "N/A"}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          // Updated row with disabled Take Away button for tables
                          Row(
                            children: [
                              Expanded(
                                child: Button.filled(
                                  height: 40,
                                  onPressed: widget.isTable
                                      ? () {} // Use an empty function instead of null
                                      : () {
                                          setState(() {
                                            isTakeaway = true;
                                          });
                                        },
                                  label: 'Take Away',
                                  color: widget.isTable
                                      ? AppColors.grey.withOpacity(
                                          0.6) // Grayed out for tables
                                      : (isTakeaway
                                          ? AppColors.primary
                                          : AppColors.grey),
                                ),
                              ),
                              const SpaceWidth(8.0),
                              Expanded(
                                child: Button.filled(
                                  height: 40,
                                  onPressed: () {
                                    setState(() {
                                      isTakeaway =
                                          false; // Force dine in for tables
                                    });
                                  },
                                  label: 'Dine In',
                                  color: !isTakeaway
                                      ? AppColors.primary
                                      : AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 130,
                              ),
                              SizedBox(
                                width: 50.0,
                                child: Text(
                                  'Qty',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8),
                          const Divider(),
                          const SpaceHeight(8),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const Center(
                                  child: Text('No Items'),
                                ),
                                loaded: (products,
                                    discountModel,
                                    discount,
                                    discountAmount,
                                    tax,
                                    serviceCharge,
                                    totalQuantity,
                                    totalPrice,
                                    draftName) {
                                  if (products.isEmpty) {
                                    return const Center(
                                      child: Text('No Items'),
                                    );
                                  }
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        OrderMenu(data: products[index]),
                                    separatorBuilder: (context, index) =>
                                        const SpaceHeight(1.0),
                                    itemCount: products.length,
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColumnButton(
                                label: 'Diskon',
                                svgGenImage: Assets.icons.diskon,
                                onPressed: () => showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const DiscountDialog(),
                                ),
                              ),
                              ColumnButton(
                                label: 'Pajak',
                                svgGenImage: Assets.icons.pajak,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => const TaxDialog(),
                                ),
                              ),
                              ColumnButton(
                                label: 'Layanan',
                                svgGenImage: Assets.icons.layanan,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => const ServiceDialog(),
                                ),
                              ),
                              ColumnButton(
                                label: 'Member',
                                svgGenImage: Assets.icons.member,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => const MemberDialog(),
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pajak',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final tax = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) {
                                        if (products.isEmpty) {
                                          return 0;
                                        }
                                        return tax;
                                      });
                                  return Text(
                                    '$tax %',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Layanan',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final serviceCharge = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) {
                                        return serviceCharge;
                                      });
                                  return Text(
                                    '$serviceCharge %',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Diskon',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Text('0 %'),
                                    loaded: (products,
                                        discounts,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      if (discounts.isEmpty) {
                                        return const Text(
                                          '0 %',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      }

                                      return Text(
                                        '$discount %',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Jumlah Diskon',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Text('Rp 0'),
                                    loaded: (products,
                                        discounts,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      return Text(
                                        discountAmount.currencyFormatRp,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sub total',
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) {
                                        if (products.isEmpty) {
                                          return 0;
                                        }
                                        return products
                                            .map((e) =>
                                                e.product.price!
                                                    .toIntegerFromText *
                                                e.quantity)
                                            .reduce((value, element) =>
                                                value + element);
                                      });

                                  return Text(
                                    price.currencyFormatRp,
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(100.0),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ColoredBox(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          child: Button.filled(
                            onPressed: () {
                              context.push(ConfirmPaymentPage(
                                isTable: widget.isTable,
                                table: widget.table,
                                orderType: widget.isTable
                                    ? 'dine_in' // Force dine_in for tables
                                    : (isTakeaway
                                        ? 'take_away'
                                        : 'dine_in'), // Use selection for non-tables
                              ));
                            },
                            label: 'Lanjutkan Pembayaran',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to show when search returns no results
  Widget _buildNoSearchResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpaceHeight(40),
        const Icon(
          Icons.search_off,
          size: 80,
          color: Colors.grey,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Tidak ada hasil untuk "$searchQuery"',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              searchQuery = '';
            });
          },
          child: const Text('Hapus pencarian'),
        ),
      ],
    );
  }
}

class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpaceHeight(40),
        Assets.icons.noProduct.svg(),
        const SizedBox(height: 40.0),
        const Text(
          'Belum Ada Produk',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
