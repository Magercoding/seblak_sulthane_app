import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class OrderMenu extends StatelessWidget {
  final ProductQuantity data;
  const OrderMenu({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: Image.network(
                data.product.image!.contains('http')
                    ? data.product.image!
                    : '${Variables.baseUrl}/${data.product.image}',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SpaceWidth(12),

          // Product Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.product.name ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SpaceHeight(4),
                Text(
                  data.product.price!.toIntegerFromText.currencyFormatRp,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls Section
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context
                      .read<CheckoutBloc>()
                      .add(CheckoutEvent.removeItem(data.product));
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: AppColors.white,
                  child: const Icon(
                    Icons.remove_circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
                child: Center(
                  child: Text(
                    data.quantity.toString(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<CheckoutBloc>()
                      .add(CheckoutEvent.addItem(data.product));
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: AppColors.white,
                  child: const Icon(
                    Icons.add_circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SpaceWidth(8),

          // Total Price Section
          SizedBox(
            width: 80.0,
            child: Text(
              (data.product.price!.toIntegerFromText * data.quantity)
                  .currencyFormatRp,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
