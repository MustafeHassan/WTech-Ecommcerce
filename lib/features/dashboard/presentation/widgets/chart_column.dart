import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/theme/colors.dart';

class ChartColumn extends StatelessWidget {
  const ChartColumn({
    Key? key,
    required List<ChartColumnData> chartDataColumn,
  })  : _chartDataColumn = chartDataColumn,
        super(key: key);

  final List<ChartColumnData> _chartDataColumn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: AppColor.white,
      height: 350,
      child: SfCartesianChart(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        title: ChartTitle(
          textStyle: Theme.of(context).textTheme.headline4,
          text: 'Sales Statistics (\$)',
          alignment: ChartAlignment.near,
        ),
        primaryXAxis: CategoryAxis(),
        enableSideBySideSeriesPlacement: true,
        series: <ChartSeries<ChartColumnData, String>>[
          ColumnSeries<ChartColumnData, String>(
              dataSource: _chartDataColumn,
              xValueMapper: (ChartColumnData data, _) => data.monthX,
              yValueMapper: (ChartColumnData data, _) {
                return data.totalY;
              }),
          ColumnSeries<ChartColumnData, String>(
            dataSource: _chartDataColumn,
            xValueMapper: (ChartColumnData data, _) => data.monthX,
            yValueMapper: (ChartColumnData data, _) {
              return data.totalY;
            },
          ),
        ],
      ),
    );
  }
}

class ChartColumnData {
  final String monthX;
  final int totalY;
  ChartColumnData({
    required this.monthX,
    required this.totalY,
  });
}

class ChartDataS {
  ChartDataS(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}
