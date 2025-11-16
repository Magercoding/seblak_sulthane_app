import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class OrderItemWidget extends StatelessWidget {
  final ProductQuantity data;
  const OrderItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: _buildProductImage(),
            ),
          ),
          const SpaceWidth(12),
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
                _buildProductPrice(),
              ],
            ),
          ),
          // Only show quantity, no buttons
          SizedBox(
            width: 40.0,
            child: Center(
              child: Text(
                'x${data.quantity.toString()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SpaceWidth(8),
          SizedBox(
            width: 80.0,
            child: _buildTotalPrice(),
          ),
        ],
      ),
    );
  }

  // Safely build product image
  Widget _buildProductImage() {
    // Check if image is null or empty
    if (data.product.image == null || data.product.image!.isEmpty) {
      return Container(
        width: 50.0,
        height: 50.0,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      );
    }

    // Build image with proper URL handling
    return Image.network(
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
    );
  }

  // Safely build product price
  Widget _buildProductPrice() {
    try {
      // Check if price is null
      if (data.product.price == null) {
        return Text(
          'Price not available',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        );
      }

      // Try to convert price to integer
      return Text(
        data.product.price!.toIntegerFromText.currencyFormatRp,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      );
    } catch (e) {
      // Handle any conversion errors
      return Text(
        'Invalid price',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      );
    }
  }

  // Safely build total price
  Widget _buildTotalPrice() {
    try {
      // Check if price is null
      if (data.product.price == null) {
        return const Text(
          'N/A',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      // Calculate and display total price
      return Text(
        (data.product.price!.toIntegerFromText * data.quantity)
            .currencyFormatRp,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      );
    } catch (e) {
      // Handle any calculation errors
      return const Text(
        'Error',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
