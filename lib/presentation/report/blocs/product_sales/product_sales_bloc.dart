import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/order_item_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/product_sales_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_sales_event.dart';
part 'product_sales_state.dart';
part 'product_sales_bloc.freezed.dart';

class ProductSalesBloc extends Bloc<ProductSalesEvent, ProductSalesState> {
  final OrderItemRemoteDatasource datasource;

  ProductSalesBloc(this.datasource) : super(const _Initial()) {
    on<_GetProductSales>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.getProductSalesByRangeDate(
        event.startDate,
        event.endDate,
        event.outletId,
      );

      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data != null && r.data!.isNotEmpty) {
            final Map<String, double> dataMap = {};

            for (var product in r.data!) {
              dataMap[product.productName] =
                  double.parse(product.totalQuantity);
            }

            if (dataMap.isNotEmpty) {
              emit(_Success(r.data!));
            } else {
              emit(const _Error("No product sales data for this outlet"));
            }
          } else {
            emit(const _Error("No product sales data for this outlet"));
          }
        },
      );
    });
  }
}
