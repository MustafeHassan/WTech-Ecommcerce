import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.showCheckBox = false,
    this.onCheckBoxSelect,
    this.scrollController,
  }) : super(key: key);
  final List<String> columns;
  final List<dynamic> rows;
  final bool showCheckBox;
  final ValueChanged<bool?>? onCheckBoxSelect;
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 80,
            onSelectAll: (value) {},
            showCheckboxColumn: showCheckBox,
            columns: List.generate(
              columns.length,
              (index) => DataColumn(
                  label: Text(
                columns[index],
              )),
            ).toList(),
            rows: List.generate(
              rows.length,
              (index) => DataRow(onSelectChanged: (value) {}, cells: [
                DataCell(
                  Text(rows[index]['ID']),
                ),
                DataCell(
                  Text(rows[index]['Name']),
                ),
                DataCell(
                  Text(rows[index]['Email']),
                ),
                DataCell(
                  Text(rows[index]['Total']),
                ),
                DataCell(
                  OrderStatus(
                    status: '${rows[index]['Status']}',
                    color: AppColor.green,
                  ),
                ),
                DataCell(
                  Text(rows[index]['Date']),
                ),
                DataCell(
                  rows[index]['Action'],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: color,
            ),
      ),
    );
  }
}
