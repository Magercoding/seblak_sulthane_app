import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/utils/timezone_helper.dart';
import 'package:seblak_sulthane_app/data/dataoutputs/print_dataoutputs.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/daily_cash_bloc/daily_cash_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/daily_cash_info_card.dart';

class DailyCashHistoryPage extends StatefulWidget {
  const DailyCashHistoryPage({super.key});

  @override
  State<DailyCashHistoryPage> createState() => _DailyCashHistoryPageState();
}

class _DailyCashHistoryPageState extends State<DailyCashHistoryPage> {
  late DailyCashBloc _dailyCashBloc;
  String _selectedDate = '';

  @override
  void initState() {
    super.initState();
    _dailyCashBloc = context.read<DailyCashBloc>();
    _selectedDate = _dailyCashBloc.getTodayDate();
    _loadDailyCash();
  }

  void _loadDailyCash() {
    _dailyCashBloc.add(DailyCashEvent.fetchDailyCash(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Uang Harian'),
        centerTitle: true,
      ),
      body: BlocConsumer<DailyCashBloc, DailyCashState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildDateSelector(),
              const SpaceHeight(24),
              state.maybeWhen(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                shiftsLoaded: (shifts, activeShiftId) {
                  if (shifts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Tidak ada data kas untuk tanggal ini',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  // Hitung total summary
                  final totalSummary = _calculateTotalSummary(shifts);

                  // Tampilkan semua shift
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Summary Total di awal
                      _buildSummaryCard(totalSummary, shifts.length),
                      const SpaceHeight(24),
                      Text(
                        'Detail Per Shift (${shifts.length})',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(16),
                      ...shifts.asMap().entries.map((entry) {
                        final index = entry.key;
                        final shift = entry.value;
                        final isActive = shift.id == activeShiftId;
                        
                        return Column(
                          children: [
                            _buildShiftCard(shift, index + 1, isActive),
                            const SpaceHeight(16),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                },
                loaded: (dailyCash) {
                  // Handle single shift (backward compatibility)
                  return _buildShiftCard(dailyCash, 1, false);
                },
                orElse: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Tidak ada data kas untuk tanggal ini',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SpaceHeight(4),
                Text(
                  DateFormat('dd MMMM yyyy')
                      .format(DateFormat('yyyy-MM-dd').parse(_selectedDate)),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: AppColors.primary),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateFormat('yyyy-MM-dd').parse(_selectedDate),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );

              if (picked != null) {
                setState(() {
                  _selectedDate = _dailyCashBloc.formatDate(picked);
                  _loadDailyCash();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(DailyCashModel shift, int shiftNumber, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isActive ? Colors.green : AppColors.card,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan nomor shift dan status
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isActive 
                  ? Colors.green.withOpacity(0.1)
                  : (shift.isClosed == true 
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green
                        : (shift.isClosed == true ? Colors.grey : Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Shift $shiftNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SpaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (shift.shiftName != null)
                        Text(
                          shift.shiftName!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SpaceHeight(4),
                      Text(
                        isActive
                            ? 'Status: Aktif'
                            : (shift.isClosed == true
                                ? 'Status: Ditutup'
                                : 'Status: Tidak Aktif'),
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive
                              ? Colors.green
                              : (shift.isClosed == true
                                  ? Colors.grey
                                  : Colors.blue),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
          ),
          // Waktu buka dan tutup
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shift.openedAt != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SpaceWidth(8),
                      Text(
                        'Buka: ${_formatDateTime(shift.openedAt!)}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SpaceHeight(8),
                ],
                if (shift.closedAt != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.lock_clock, size: 16, color: Colors.grey),
                      const SpaceWidth(8),
                      Text(
                        'Tutup: ${_formatDateTime(shift.closedAt!)}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SpaceHeight(16),
                ],
                // Info card untuk detail kas
                DailyCashInfoCard(dailyCash: shift),
                const SpaceHeight(16),
                // Tombol Cetak Struk Laporan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _handlePrintShift(context, shift, shiftNumber),
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      'Cetak Struk Laporan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      final wibDate = TimezoneHelper.toWIB(date);
      return DateFormat('dd MMM yyyy, HH:mm').format(wibDate);
    } catch (_) {
      return isoString;
    }
  }

  Future<void> _handlePrintShift(
      BuildContext context, DailyCashModel shift, int shiftNumber) async {
    BuildContext? dialogContext;
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          dialogContext = ctx;
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Mencetak laporan Shift $shiftNumber...'),
              ],
            ),
          );
        },
      );

      // Check printer connection
      log('Checking printer connection...');
      final bool isConnected = await PrintBluetoothThermal.connectionStatus;
      log('Printer connection status: $isConnected');

      if (!isConnected) {
        if (context.mounted && dialogContext != null) {
          Navigator.pop(dialogContext!);
        }
        _showPrintStatusDialog(
          context,
          false,
          'Printer tidak terhubung. Silakan hubungkan printer terlebih dahulu di menu Pengaturan > Kelola Printer.',
        );
        return;
      }

      // Get receipt size
      final sizeReceipt = await AuthLocalDataSource().getSizeReceipt();
      int receiptSize;
      try {
        receiptSize = int.parse(sizeReceipt);
      } catch (e) {
        log('Error parsing receipt size: $sizeReceipt');
        receiptSize = 80;
      }

      // Generate print bytes
      log('Generating print bytes for shift $shiftNumber...');
      final List<int> printBytes = await PrintDataoutputs.instance
          .printDailyCashShift(shift, shiftNumber, receiptSize);

      log('Generated print bytes: ${printBytes.length} bytes');

      if (printBytes.isEmpty) {
        throw Exception('Print bytes is empty');
      }

      // Close loading dialog
      if (context.mounted && dialogContext != null) {
        Navigator.pop(dialogContext!);
      }

      // Print
      log('Sending ${printBytes.length} bytes to printer...');
      final result = await PrintBluetoothThermal.writeBytes(printBytes);
      log('Print result: $result');

      if (context.mounted) {
        if (result) {
          _showPrintStatusDialog(
              context, true, 'Laporan Shift $shiftNumber berhasil dicetak.');
        } else {
          _showPrintStatusDialog(context, false,
              'Gagal mencetak laporan Shift $shiftNumber. Periksa apakah printer terhubung dan diatur dengan benar.');
        }
      }
    } catch (e, stackTrace) {
      log("Error printing shift report: $e");
      log("Stack trace: $stackTrace");

      if (context.mounted && dialogContext != null) {
        Navigator.pop(dialogContext!);
      }

      if (context.mounted) {
        String errorMessage = 'Error: ${e.toString()}';
        if (e.toString().contains('connection') ||
            e.toString().contains('bluetooth')) {
          errorMessage =
              'Gagal mencetak. Pastikan printer terhubung dan Bluetooth aktif.';
        }
        _showPrintStatusDialog(context, false, errorMessage);
      }
    }
  }

  void _showPrintStatusDialog(
      BuildContext context, bool isSuccess, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: isSuccess
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 60)
                  : const Icon(Icons.error_outline,
                      color: Colors.red, size: 60),
            ),
            const SizedBox(height: 16.0),
            Text(
              isSuccess ? 'Cetak Berhasil' : 'Cetak Gagal',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  DailyCashModel _calculateTotalSummary(List<DailyCashModel> shifts) {
    int totalOpeningBalance = 0;
    int totalExpenses = 0;
    int totalCashSales = 0;
    int totalQrisSales = 0;
    int totalQrisFee = 0;
    int totalClosingBalance = 0;
    int totalFinalCashClosing = 0;
    String? combinedExpensesNote;

    for (var shift in shifts) {
      totalOpeningBalance += shift.openingBalance ?? 0;
      totalExpenses += shift.expenses ?? 0;
      
      final cashSales = shift.getCashSalesAsInt() ?? 0;
      final qrisSales = shift.getQrisSalesAsInt() ?? 0;
      final qrisFee = shift.qrisFee ?? 0;
      
      totalCashSales += cashSales;
      totalQrisSales += qrisSales;
      totalQrisFee += qrisFee;
      
      // Untuk closing balance, jika null (shift masih aktif), hitung dari data yang ada
      if (shift.closingBalance != null) {
        totalClosingBalance += shift.closingBalance!;
      } else {
        // Hitung closing balance untuk shift aktif
        final calculatedClosing = (shift.openingBalance ?? 0) + 
            cashSales + qrisSales - (shift.expenses ?? 0) - qrisFee;
        totalClosingBalance += calculatedClosing;
      }
      
      // Untuk final cash closing, jika null, hitung dari data yang ada
      final finalCashClosing = shift.getFinalCashClosingAsInt();
      if (finalCashClosing != null) {
        totalFinalCashClosing += finalCashClosing;
      } else {
        // Hitung final cash closing untuk shift aktif
        final calculatedFinalCash = (shift.openingBalance ?? 0) + 
            cashSales - (shift.expenses ?? 0);
        totalFinalCashClosing += calculatedFinalCash;
      }
      
      // Gabungkan expenses note
      if (shift.expensesNote != null && shift.expensesNote!.isNotEmpty) {
        if (combinedExpensesNote == null) {
          combinedExpensesNote = shift.expensesNote;
        } else {
          combinedExpensesNote = '$combinedExpensesNote\n\n${shift.expensesNote}';
        }
      }
    }

    // Buat model summary
    return DailyCashModel(
      id: null,
      outletId: shifts.isNotEmpty ? shifts.first.outletId : null,
      userId: null,
      date: shifts.isNotEmpty ? shifts.first.date : null,
      shiftName: 'Total Semua Shift',
      openedAt: null,
      closedAt: null,
      closedBy: null,
      isClosed: null,
      openingBalance: totalOpeningBalance,
      expenses: totalExpenses,
      expensesNote: combinedExpensesNote,
      cashSales: totalCashSales,
      qrisSales: totalQrisSales,
      qrisFee: totalQrisFee,
      effectiveExpenses: null,
      closingBalance: totalClosingBalance,
      finalCashClosing: totalFinalCashClosing,
      createdAt: null,
      updatedAt: null,
    );
  }

  Widget _buildSummaryCard(DailyCashModel summary, int totalShifts) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.primary,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan style khusus
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.summarize, color: Colors.white, size: 24),
                const SpaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$totalShifts Shift',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Detail summary menggunakan DailyCashInfoCard
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DailyCashInfoCard(dailyCash: summary),
          ),
        ],
      ),
    );
  }
}

