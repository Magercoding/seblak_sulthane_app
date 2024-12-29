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
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: Image.network(
                    data.product.image!.contains('http')
                        ? data.product.image!
                        : '${Variables.baseUrl}/${data.product.image}',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(data.product.name ?? "-",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                    data.product.price!.toIntegerFromText.currencyFormatRp),
              ),
            ),
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
                  )),
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
      ],
    );
  }
}
