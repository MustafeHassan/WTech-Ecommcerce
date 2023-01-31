import 'package:flutter/material.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({
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
            onSelectAll: (value) {},
            showCheckboxColumn: showCheckBox,
            horizontalMargin: 30,
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
                  Text(rows[index]['Description']),
                ),
                DataCell(
                  Text(rows[index]['Orders']),
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
