part of 'tax_bloc.dart';

@freezed
class TaxEvent with _$TaxEvent {
  const factory TaxEvent.started() = _Started;
  const factory TaxEvent.add(TaxModel tax) = _Add;
  const factory TaxEvent.update(TaxModel tax) = _Update;
}