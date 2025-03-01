part of 'outlet_bloc.dart';

@freezed
class OutletState with _$OutletState {
  const factory OutletState.initial() = _Initial;
  const factory OutletState.loading() = _Loading;
  const factory OutletState.loaded(OutletModel outlet) = _Loaded;
  const factory OutletState.loadedAll(List<OutletModel> outlets) = _LoadedAll;
  const factory OutletState.saved(OutletModel outlet) = _Saved;
  const factory OutletState.error(String message) = _Error;
}
