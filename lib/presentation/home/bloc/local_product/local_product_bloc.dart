import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/core/core.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';

part 'local_product_bloc.freezed.dart';
part 'local_product_event.dart';
part 'local_product_state.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final ProductLocalDatasource productLocalDatasource;

  LocalProductBloc(this.productLocalDatasource) : super(const _Initial()) {
    on<_FilterByPriceRange>((event, emit) async {
      emit(const _Loading());
      final allProducts = await productLocalDatasource.getProducts();
      final filteredProducts =
          _filterProductsByPriceRange(allProducts, event.priceRange);
      emit(_Loaded(filteredProducts));
    });

    on<_Started>((event, emit) {});

    on<_GetLocalProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalDatasource.getProducts();
      emit(_Loaded(result));
    });
  }
  List<Product> _filterProductsByPriceRange(
      List<Product> products, String priceRange) {
    List<Product> filteredProducts;

    switch (priceRange) {
      case '500':
        filteredProducts = products
            .where((product) => product.price?.toIntegerFromText == 500)
            .toList();
        break;
      case '1000':
        filteredProducts = products
            .where((product) => product.price?.toIntegerFromText == 1000)
            .toList();
        break;
      case '1500-2000':
        filteredProducts = products.where((product) {
          final price = product.price?.toIntegerFromText ?? 0;
          return price >= 1500 && price <= 2000;
        }).toList();
        break;
      case '2500':
        filteredProducts = products
            .where((product) => product.price?.toIntegerFromText == 2500)
            .toList();
        break;
      case '3000-9000':
        filteredProducts = products.where((product) {
          final price = product.price?.toIntegerFromText ?? 0;
          return price >= 3000 && price <= 9000;
        }).toList();

        filteredProducts.sort((a, b) => (a.price?.toIntegerFromText ?? 0)
            .compareTo(b.price?.toIntegerFromText ?? 0));
        break;
      default:
        filteredProducts = products;
    }

    return filteredProducts;
  }
}
