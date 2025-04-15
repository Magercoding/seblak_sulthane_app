import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_product/sync_product_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_member/sync_member_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_discount/sync_discount_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_category/sync_category_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  // Flags to track sync button presses
  bool productSyncRequested = false;
  bool categorySyncRequested = false;
  bool memberSyncRequested = false;
  bool discountSyncRequested = false;
  bool orderSyncRequested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSyncCard(
                title: 'Sync Product',
                subtitle: 'Sync products from server to local database',
                icon: Icons.shopping_cart,
                syncWidget: BlocConsumer<SyncProductBloc, SyncProductState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        if (productSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            productSyncRequested = false;
                          });
                        }
                      },
                      loaded: (productResponseModel) {
                        if (productSyncRequested) {
                          ProductLocalDatasource.instance.deleteAllProducts();
                          ProductLocalDatasource.instance.insertProducts(
                            productResponseModel.data!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Product Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            productSyncRequested = false;
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                productSyncRequested = true;
                              });
                              context
                                  .read<SyncProductBloc>()
                                  .add(const SyncProductEvent.syncProduct());
                            },
                            child: const Text('Sync Product'));
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildSyncCard(
                title: 'Sync Category',
                subtitle: 'Sync categories from server to local database',
                icon: Icons.category,
                syncWidget: BlocConsumer<SyncCategoryBloc, SyncCategoryState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        if (categorySyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            categorySyncRequested = false;
                          });
                        }
                      },
                      loaded: (categoryResponseModel) {
                        if (categorySyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Category Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            categorySyncRequested = false;
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              categorySyncRequested = true;
                            });
                            context
                                .read<SyncCategoryBloc>()
                                .add(const SyncCategoryEvent.syncCategory());
                          },
                          child: const Text('Sync Category'),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildSyncCard(
                title: 'Sync Member',
                subtitle: 'Sync members from server to local database',
                icon: Icons.people,
                syncWidget: BlocConsumer<SyncMemberBloc, SyncMemberState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        if (memberSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            memberSyncRequested = false;
                          });
                        }
                      },
                      loaded: (memberResponseModel) {
                        if (memberSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Member Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            memberSyncRequested = false;
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              memberSyncRequested = true;
                            });
                            context
                                .read<SyncMemberBloc>()
                                .add(const SyncMemberEvent.syncMember());
                          },
                          child: const Text('Sync Member'),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildSyncCard(
                title: 'Sync Discount',
                subtitle: 'Sync discounts from server to local database',
                icon: Icons.discount,
                syncWidget: BlocConsumer<SyncDiscountBloc, SyncDiscountState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        if (discountSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            discountSyncRequested = false;
                          });
                        }
                      },
                      loaded: (discountResponseModel) {
                        if (discountSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Discount Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            discountSyncRequested = false;
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              discountSyncRequested = true;
                            });
                            context
                                .read<SyncDiscountBloc>()
                                .add(const SyncDiscountEvent.syncDiscount());
                          },
                          child: const Text('Sync Discount'),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildSyncCard(
                title: 'Sync Order',
                subtitle: 'Sync orders from local database to server',
                icon: Icons.receipt_long,
                syncWidget: BlocConsumer<SyncOrderBloc, SyncOrderState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      error: (message) {
                        if (orderSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            orderSyncRequested = false;
                          });
                        }
                      },
                      loaded: () {
                        if (orderSyncRequested) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Order Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            orderSyncRequested = false;
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderSyncRequested = true;
                            });
                            context
                                .read<SyncOrderBloc>()
                                .add(const SyncOrderEvent.syncOrder());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Sync Order'),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSyncCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget syncWidget,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 150,
              child: syncWidget,
            ),
          ],
        ),
      ),
    );
  }
}
