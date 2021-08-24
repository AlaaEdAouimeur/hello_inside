import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:hello_inside_task/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:hello_inside_task/utils/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  @override
  ChartViewState createState() => ChartViewState();
}

class ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorCubit, SensorState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is SensorLoading)
          return _buildLoading();
        else if (state is SensorLoaded) {
          return _buildLoadedData(state.sensorData.entries[0]);
        } else if (state is SensorError)
          return _buildError(state.message);
        else
          return Container();
      },
    );
  }

  Widget _buildLoadedData(Entry entry) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width - 20,
            child: SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enablePanning: true,
              ),
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                intervalType: DateTimeIntervalType.minutes,
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 50,
                maximum: 150,
                interval: 50,
                axisLine: const AxisLine(width: 0),
                labelFormat: '{value}mg/dL',
                majorTickLines: const MajorTickLines(size: 0),
              ),
              series: _getStuf(entry),
            ),
          )
        ],
      );
  List<SplineSeries<Measurement, DateTime>> _getStuf(Entry entry) {
    return [
      SplineSeries(
          dataSource: entry.measurements,
          xValueMapper: (Measurement m, _) => m.date,
          yValueMapper: (Measurement m, _) => m.value,
          pointColorMapper: (Measurement m, _) =>
              m.isOutOfRange ? Colors.red : Colors.blue)
    ];
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
  Widget _buildError(String error) => Center(
        child: Text(error),
      );
}
/*  Widget _buildLoadedData(Entry entry) {
    List<FlSpot> fls = entry.measurements
        .map(
            (e) => FlSpot(e.date.toChartMinutes.toDouble(), e.value.toDouble()))
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.blueGrey,
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LineChart(
              
              LineChartData(
                
                  maxX: 1440,
                  maxY: 180,
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(y: 80, color: Colors.amber),
                      HorizontalLine(y: 110, color: Colors.amber)
                    ],  
                  ),
                  axisTitleData:
                      FlAxisTitleData(leftTitle: AxisTitle(titleText: 'dsd')),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (val) {
                        switch (val.toInt()) {
                          case 0:
                            return '0am';
                          case 360:
                            return '6am';
                          case 720:
                            return '12am';
                          case 1080:
                            return '6pm';
                          case 1440:
                            return '12am';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      getTitles: (val) {
                        print(val);
                        switch (val.toInt()) {
                          case 110:
                            return '110';
                          case 80:
                            return '80';
                          case 200:
                            return '200';
                          case 50:
                            return '50';

                          default:
                            return '';
                        }
                      },
                      showTitles: true,
                      margin: 8,
                      reservedSize: 30,
                      getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff75729e),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.blueGrey,
                  lineBarsData: [LineChartBarData(spots: fls, isCurved: true)]),

              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.red,
          child: Container(),
        ))
      ],
    );
  }*/