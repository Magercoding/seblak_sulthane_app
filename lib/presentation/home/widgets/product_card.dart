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
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.card),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.disabled.withOpacity(0.4),
                    child: _buildProductImage(),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9.0)),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
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
                            final inCart = products
                                .any((element) => element.product == data);
                            final quantity = inCart
                                ? products
                                    .firstWhere(
                                        (element) => element.product == data)
                                    .quantity
                                : 0;

                            return Container(
                              width: quantity > 0 ? 40 : 36,
                              height: quantity > 0 ? 40 : 36,
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
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
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Safely build product image widget
  Widget _buildProductImage() {
    if (data.image == null || data.image!.isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      );
    }

    return Image.network(
      data.image!.contains('http')
          ? data.image!
          : '${Variables.baseUrl}/${data.image}',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
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
