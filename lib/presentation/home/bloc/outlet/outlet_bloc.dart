import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';

part 'outlet_bloc.freezed.dart';
part 'outlet_event.dart';
part 'outlet_state.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final OutletLocalDataSource outletLocalDataSource;

  OutletBloc(
    this.outletLocalDataSource,
  ) : super(const _Initial()) {
    on<_GetOutlet>((event, emit) async {
      emit(const _Loading());
      try {
        log("Getting outlet with id: ${event.id}");

        final allOutlets = await outletLocalDataSource.getAllOutlets();
        log("All available outlets: ${allOutlets.map((o) => '${o.id}: ${o.name}').join(', ')}");

        final outlet = await outletLocalDataSource.getOutletById(event.id);

        if (outlet != null) {
          log("Found outlet: ${outlet.toJson()}");
          emit(_Loaded(outlet));
        } else {
          log("Outlet not found with ID: ${event.id}");
          emit(const _Error('Outlet not found'));
        }
      } catch (e) {
        log("Error getting outlet: $e");
        emit(_Error('Failed to get outlet: ${e.toString()}'));
      }
    });

    on<_SaveOutlet>((event, emit) async {
      emit(const _Loading());
      try {
        if (event.outlet == null) {
          emit(const _Error('Cannot save null outlet'));
          return;
        }

        log("Saving outlet: ${event.outlet.toJson()}");

        final result = await outletLocalDataSource.saveOutlet(event.outlet);

        if (result) {
          emit(_Saved(event.outlet));
        } else {
          emit(const _Error('Failed to save outlet'));
        }
      } catch (e) {
        log("Error saving outlet: $e");
        emit(_Error('Failed to save outlet: ${e.toString()}'));
      }
    });

    on<_GetAllOutlets>((event, emit) async {
      emit(const _Loading());
      try {
        log("Getting all outlets");

        final allOutlets = await outletLocalDataSource.getAllOutlets();
        print(
            'Available outlets before report generation: ${allOutlets.length}');
        for (var outlet in allOutlets) {
          print('Outlet ${outlet.id}: ${outlet.name}, ${outlet.address}');
        }

        if (allOutlets == null) {
          emit(const _Error('Failed to retrieve outlets'));
          return;
        }

        emit(_LoadedAll(allOutlets));
      } catch (e) {
        log("Error getting all outlets: $e");
        emit(_Error('Failed to get outlets: ${e.toString()}'));
      }
    });
  }
}
