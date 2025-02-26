import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:seblak_sulthane_app/data/models/response/product_sales_response_model.dart';

class ProductSalesChartWidgets extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final List<ProductSales> productSales;

  const ProductSalesChartWidgets({
    Key? key,
    required this.title,
    required this.searchDateFormatted,
    required this.productSales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create the data map for pie chart
    final Map<String, double> dataMap = {};
    
    for (var product in productSales) {
      dataMap[product.productName] = double.parse(product.totalQuantity);
    }

    // Generate random colors for the chart
    final List<Color> colorList = [
      const Color(0xff0293ee),
      const Color(0xfff8b250),
      const Color(0xff845bef),
      const Color(0xff13d38e),
      const Color(0xfffd8090),
      const Color(0xff68297c),
      const Color(0xff6fb33c),
      const Color(0xffa1887f),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            searchDateFormatted,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 32.0),
          
          if (dataMap.isEmpty)
            // Show message when no data is available
            const Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'No product sales data available for this outlet in the selected date range',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            // Show pie chart when data is available
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Product Sales Distribution',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Product sales table
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Percentage')),
                    ],
                    rows: _createProductRows(dataMap),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<DataRow> _createProductRows(Map<String, double> dataMap) {
    final double total = dataMap.values.fold(0, (sum, value) => sum + value);
    
    return dataMap.entries.map((entry) {
      final percentage = (entry.value / total * 100).toStringAsFixed(1);
      
      return DataRow(
        cells: [
          DataCell(Text(entry.key)),
          DataCell(Text(entry.value.toStringAsFixed(0))),
          DataCell(Text('$percentage%')),
        ],
      );
    }).toList();
  }
}