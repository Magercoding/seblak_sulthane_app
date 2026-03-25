import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/settings_local_datasource.dart';

import '../../models/tax_model.dart';

part 'tax_bloc.freezed.dart';
part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final SettingsLocalDatasource _localDatasource = SettingsLocalDatasource();

  TaxBloc() : super(const TaxState.initial()) {
    on<_Started>((event, emit) async {
      try {
        final tax = await _localDatasource.getTax();
        final serviceCharge = await _localDatasource.getServiceCharge();

        final taxes = [
          TaxModel(
            name: 'Biaya Layanan',
            type: TaxType.layanan,
            value: serviceCharge,
          ),
          tax,
        ];

        emit(TaxState.loaded(taxes));
      } catch (e) {
        emit(TaxState.error(e.toString()));
      }
    });

    on<_Add>((event, emit) async {
      try {
        if (event.tax.type.isLayanan) {
          await _localDatasource.saveServiceCharge(event.tax.value);
        } else {
          await _localDatasource.saveTax(event.tax);
        }

        // Reload from source of truth
        add(const TaxEvent.started());
      } catch (e) {
        emit(TaxState.error(e.toString()));
      }
    });

    on<_Update>((event, emit) async {
      try {
        if (event.tax.type.isLayanan) {
          await _localDatasource.saveServiceCharge(event.tax.value);
        } else {
          await _localDatasource.saveTax(event.tax);
        }

        // Reload from source of truth
        add(const TaxEvent.started());
      } catch (e) {
        emit(TaxState.error(e.toString()));
      }
    });
  }
}
