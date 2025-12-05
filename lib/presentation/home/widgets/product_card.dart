import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/core/utils/sound_feedback.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  const ProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = (data.isFavorite ?? 0) == 1;

    return GestureDetector(
      onTap: () {
        // Play sound feedback
        SoundFeedback.playTapSound();
        context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.card),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.disabled.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    child: _buildProductImage(),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    data.name ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        data.category?.name ?? '-',
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildProductPrice(),
                    ),
                  ],
                ),
              ],
            ),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  loaded: (products,
                      discountModel,
                      discount,
                      discountAmount,
                      tax,
                      serviceCharge,
                      totalQuantity,
                      totalPrice,
                      draftName) {
                    final inCart =
                        products.any((element) => element.product == data);
                    final quantity = inCart
                        ? products
                            .firstWhere((element) => element.product == data)
                            .quantity
                        : 0;

                    return Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: quantity > 0 ? 40 : 36,
                        height: quantity > 0 ? 40 : 36,
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                          color: AppColors.primary,
                        ),
                        child: quantity > 0
                            ? Center(
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Assets.icons.shoppingBasket.svg(),
                      ),
                    );
                  },
                );
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Safely build product image widget
  Widget _buildProductImage() {
    // Check if image is null or empty
    if (data.image == null || data.image!.isEmpty) {
      return Container(
        width: 60,
        height: 60,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      );
    }

    // Build image with proper URL handling
    return Image.network(
      data.image!.contains('http')
          ? data.image!
          : '${Variables.baseUrl}/${data.image}',
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 60,
          height: 60,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported),
        );
      },
    );
  }

  // Safely build product price widget
  Widget _buildProductPrice() {
    try {
      // Check if price is null
      if (data.price == null) {
        return const Text(
          'Price not available',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        );
      }

      // Try to convert price to integer
      return Text(
        data.price!.toIntegerFromText.currencyFormatRp,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
      );
    } catch (e) {
      // Handle any conversion errors
      return const Text(
        'Invalid price',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
