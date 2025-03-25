import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_product/sync_product_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_member/sync_member_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_discount/sync_discount_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_category/sync_category_bloc.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
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
              BlocConsumer<SyncProductBloc, SyncProductState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: (productResponseModel) {
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
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                          onPressed: () {
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
              const SizedBox(height: 16),
              BlocConsumer<SyncCategoryBloc, SyncCategoryState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: (categoryResponseModel) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Category Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
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
              const SizedBox(height: 16),
              BlocConsumer<SyncMemberBloc, SyncMemberState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: (memberResponseModel) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Member Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
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
              const SizedBox(height: 16),
              BlocConsumer<SyncDiscountBloc, SyncDiscountState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: (discountResponseModel) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Discount Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
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
              const SizedBox(height: 16),
              BlocConsumer<SyncOrderBloc, SyncOrderState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Order Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
                          context
                              .read<SyncOrderBloc>()
                              .add(const SyncOrderEvent.syncOrder());
                        },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
