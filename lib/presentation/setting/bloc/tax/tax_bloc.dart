// tax_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/settings_local_datasource.dart';

import '../../models/tax_model.dart';

part 'tax_bloc.freezed.dart';
part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final List<TaxModel> _taxes = [];
  final SettingsLocalDatasource _localDatasource = SettingsLocalDatasource();

  TaxBloc() : super(const TaxState.initial()) {
    on<_Started>((event, emit) async {
      try {
        // Ambil data tax dan service charge
        final tax = await _localDatasource.getTax();
        final serviceCharge = await _localDatasource.getServiceCharge();

        print('Initial Tax Value: ${tax.value}');
        print('Initial Service Charge: $serviceCharge');

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
        print('Error loading taxes: $e');
        emit(TaxState.error(e.toString()));
      }
    });
    // Jalankan event Started saat inisialisasi
    this.add(const TaxEvent.started());

    on<_Add>((event, emit) async {
      try {
        if (event.tax.type.isLayanan) {
          await _localDatasource.saveServiceCharge(event.tax.value);
        } else {
          await _localDatasource.saveTax(event.tax);
        }

        final index = _taxes.indexWhere((t) => t.type == event.tax.type);
        if (index != -1) {
          _taxes[index] = event.tax;
        } else {
          _taxes.add(event.tax);
        }

        emit(TaxState.loaded(List.from(_taxes)));
      } catch (e) {
        print('Error adding tax: $e');
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

        final index = _taxes.indexWhere((t) => t.type == event.tax.type);
        if (index != -1) {
          _taxes[index] = event.tax;
          emit(TaxState.loaded(List.from(_taxes)));
        }
      } catch (e) {
        print('Error updating tax: $e');
        emit(TaxState.error(e.toString()));
      }
    });
  }
}
