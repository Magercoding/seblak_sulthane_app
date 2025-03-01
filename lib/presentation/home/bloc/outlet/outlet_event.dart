part of 'outlet_bloc.dart';

@freezed
class OutletEvent with _$OutletEvent {
  const factory OutletEvent.started() = _Started;
  const factory OutletEvent.getOutlet(int id) = _GetOutlet;
  const factory OutletEvent.saveOutlet(OutletModel outlet) = _SaveOutlet;
  const factory OutletEvent.getAllOutlets() = _GetAllOutlets;
}
