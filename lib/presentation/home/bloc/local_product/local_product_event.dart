part of 'local_product_bloc.dart';

@freezed
class LocalProductEvent with _$LocalProductEvent {
  const factory LocalProductEvent.started() = _Started;
  const factory LocalProductEvent.getLocalProduct() = _GetLocalProduct;
  const factory LocalProductEvent.filterByPriceRange(String priceRange) =
      _FilterByPriceRange;
  const factory LocalProductEvent.filterByCategory(int categoryId) =
      _FilterByCategory;
}
