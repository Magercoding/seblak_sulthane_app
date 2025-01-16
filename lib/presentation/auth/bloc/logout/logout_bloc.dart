import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/datasources/auth_local_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDataSource authLocalDataSource;

  LogoutBloc(
    this.authRemoteDatasource,
  )   : authLocalDataSource = AuthLocalDataSource(),
        super(const _Initial()) {
    on<_Logout>((event, emit) async {
      try {
        print('Starting logout process...');
        emit(const _Loading());

        // Check if auth data exists before attempting logout
        final exists = await authLocalDataSource.isAuthDataExists();
        print('Auth data exists: $exists');

        if (!exists) {
          print('No auth data found, considering as already logged out');
          await authLocalDataSource.removeAuthData();
          emit(const _Success());
          return;
        }

        // Proceed with remote logout
        print('Attempting remote logout...');
        final result = await authRemoteDatasource.logout();

        result.fold(
          (error) async {
            print('Logout error: $error');
            // If unauthorized or token related error, clean local data
            if (error.toLowerCase() == 'unauthorized') {
              print('Token invalid or expired, cleaning local data');
              await authLocalDataSource.removeAuthData();
              emit(_Error(error)); // Emit error untuk trigger navigasi ke login
            } else {
              emit(_Error(error));
            }
          },
          (success) {
            print('Logout successful');
            emit(const _Success());
          },
        );
      } catch (e) {
        print('Unexpected error during logout: $e');
        // Always try to clean local data on error
        try {
          await authLocalDataSource.removeAuthData();
        } catch (e) {
          print('Error cleaning local data: $e');
        }
        emit(_Error('Unexpected error during logout: $e'));
      }
    });
  }
}
