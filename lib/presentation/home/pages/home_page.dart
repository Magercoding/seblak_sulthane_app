import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/discount_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/member_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/dialog/tax_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/pages/confirm_payment_page.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/custom_tab_barV2.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/get_categories/get_categories_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../dialog/service_dialog.dart';
import '../widgets/column_button.dart';
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
  bool isTakeaway = true;
  String searchQuery = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());
    context
        .read<GetCategoriesBloc>()
        .add(const GetCategoriesEvent.getCategories());

    if (widget.isTable) {
      isTakeaway = false;
    }

    super.initState();
  }

  void onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
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
                          onChanged: onSearchChanged,
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const SizedBox.shrink(),
                              loading: () => const CircularProgressIndicator(),
                              loaded: (categories) {
                                final tabViews = [
                                  // "Semua" tab view
                                  _buildProductGrid(searchQuery),
                                  // Price filter tab views
                                  _buildProductGrid(searchQuery,
                                      priceRange: "500"),
                                  _buildProductGrid(searchQuery,
                                      priceRange: "1000"),
                                  _buildProductGrid(searchQuery,
                                      priceRange: "1500-2000"),
                                  _buildProductGrid(searchQuery,
                                      priceRange: "2500"),
                                  _buildProductGrid(searchQuery,
                                      priceRange: "3000-9000"),
                                  // Category tab views
                                  ...categories.data.map((category) =>
                                      _buildProductGrid(searchQuery,
                                          categoryId: category.id)),
                                ];

                                return CustomTabBarV2(
                                  categories: categories.data,
                                  initialTabIndex: _selectedIndex,
                                  tabViews: tabViews,
                                );
                              },
                              error: (message) => Text('Error: $message'),
                            );
                          },
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
                          if (widget.isTable) ...[
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
                          Row(
                            children: [
                              Expanded(
                                child: Button.filled(
                                  height: 40,
                                  onPressed: widget.isTable
                                      ? () {}
                                      : () {
                                          setState(() {
                                            isTakeaway = true;
                                          });
                                        },
                                  label: 'Take Away',
                                  color: widget.isTable
                                      ? AppColors.grey.withOpacity(0.6)
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
                                      isTakeaway = false;
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
                                    ? 'dine_in'
                                    : (isTakeaway ? 'take_away' : 'dine_in'),
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
}

Widget _buildProductGrid(String searchQuery,
    {int? categoryId, String? priceRange}) {
  return SizedBox(
    child: BlocBuilder<LocalProductBloc, LocalProductState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (products) {
            if (products.isEmpty) {
              return const EmptyStateWidget();
            }

            List<Product> filteredProducts = products;

            // Apply category filter if specified
            if (categoryId != null) {
              filteredProducts = filteredProducts
                  .where((product) => product.category?.id == categoryId)
                  .toList();
            }

            // Apply price filter if specified
            if (priceRange != null) {
              filteredProducts = filteredProducts.where((product) {
                final price = product.price?.toIntegerFromText ?? 0;
                switch (priceRange) {
                  case "500":
                    return price == 500;
                  case "1000":
                    return price == 1000;
                  case "1500-2000":
                    return price >= 1500 && price <= 2000;
                  case "2500":
                    return price == 2500;
                  case "3000-9000":
                    return price >= 3000 && price <= 9000;
                  default:
                    return false;
                }
              }).toList();
            }

            // Apply search filter
            if (searchQuery.isNotEmpty) {
              filteredProducts = filteredProducts
                  .where((product) =>
                      product.name?.toLowerCase().contains(searchQuery) ??
                      false)
                  .toList();
            }

            if (filteredProducts.isEmpty) {
              return const EmptyStateWidget();
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.85,
                crossAxisCount: 3,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
              ),
              itemBuilder: (context, index) => ProductCard(
                data: filteredProducts[index],
                onCartButton: () {},
              ),
            );
          },
        );
      },
    ),
  );
}

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

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
