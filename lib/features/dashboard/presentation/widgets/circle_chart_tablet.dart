import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/theme/colors.dart';

class CircleChartTablet extends StatelessWidget {
  const CircleChartTablet({
    Key? key,
    required List<ChartData> chartData,
  })  : _chartData = chartData,
        super(key: key);

  final List<ChartData> _chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.white,
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:
                Text('Visitors', style: Theme.of(context).textTheme.headline4),
          ),
          SfCircularChart(
            annotations: [
              CircularChartAnnotation(
                widget: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Text(
                        '66%',
                        style:
                            Theme.of(context).textTheme.headline4!.copyWith(),
                      ),
                      Text(
                        'App Growth',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppColor.captionColor.withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            title: ChartTitle(
              text: 'Recent Month',
              textStyle: Theme.of(context).textTheme.headline4,
            ),
            legend: Legend(
              isVisible: true,
              isResponsive: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
            ),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                legendIconType: LegendIconType.circle,
                dataSource: _chartData,
                cornerStyle: CornerStyle.bothFlat,
                xValueMapper: (data, _) => data.title,
                yValueMapper: (data, _) => data.percentage,
                innerRadius: '120%',
                pointColorMapper: (data, index) => data.color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final Color color;
  final String title;
  final int percentage;
  ChartData({
    required this.color,
    required this.title,
    required this.percentage,
  });
}
