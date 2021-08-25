import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide CornerStyle;
import 'package:hello_inside_task/utils/extensions.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartView extends StatefulWidget {
  @override
  ChartViewState createState() => ChartViewState();
}

class ChartViewState extends State<ChartView> {
  int _pickedEntryIndex = 0;
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
          return _buildLoadedData(state.sensorData);
        } else if (state is SensorError)
          return _buildError(state.message);
        else
          return Container();
      },
    );
  }

  Widget _buildLoadedData(SensorData sensorData) {
    final entry = sensorData.entries[_pickedEntryIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: _buildCharts(entry)),
        _entryPickerWidget(sensorData),
        Expanded(flex: 2, child: _buildRangeGauge(entry))
      ],
    );
  }

  Widget _buildCharts(Entry entry) => Container(
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            maximumZoomLevel: 0.5,
          ),
          onZooming: (arg) => print(arg),
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.hours,
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            plotBands: [
              PlotBand(
                  dashArray: [10, 10],
                  textAngle: 0,
                  start: 80,
                  end: 80,
                  textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  borderColor: Colors.red,
                  borderWidth: 2),
              PlotBand(
                  dashArray: [10, 10],
                  textAngle: 0,
                  start: 110,
                  end: 110,
                  textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  borderColor: Colors.red,
                  borderWidth: 2),
            ],
            minimum: 50,
            maximum: 140,
            interval: 30,
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value}mg/dL',
            majorTickLines: const MajorTickLines(size: 0),
          ),
          series: _getSplineLines(entry),
        ),
      );
  Widget _entryPickerWidget(SensorData sensorData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _pickedEntryIndex != 0
              ? () => setState(() => _pickedEntryIndex--)
              : null,
          icon: Icon(Icons.arrow_back_ios),
        ),
        Text(sensorData.entries[_pickedEntryIndex].day.toDay),
        IconButton(
          onPressed: sensorData.entries.length - 1 != _pickedEntryIndex
              ? () => setState(() => _pickedEntryIndex++)
              : null,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  List<SplineSeries<Measurement, DateTime>> _getSplineLines(Entry entry) {
    return [
      SplineSeries(
        pointColorMapper: (Measurement m, index) => entry.countSpikes
                .where((element) => element.spikeRange.contains(index))
                .isNotEmpty
            ? Colors.red
            : Colors.blue,
        dataSource: entry.measurements,
        xValueMapper: (Measurement m, _) => m.date,
        yValueMapper: (Measurement m, _) => m.value,
      )
    ];
  }

  Widget _buildRangeGauge(Entry entry) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            endAngle: 270,
            startAngle: 270,
            showTicks: false,
            radiusFactor: 0.8,
            minimum: 0,
            maximum: 100,
            axisLineStyle: AxisLineStyle(
                cornerStyle: CornerStyle.startCurve, thickness: 5),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0,
                widget: Center(
                  child: Text(entry.getPercentage.toString() + "% in Range",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 22)),
                ),
              ),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                animationType: AnimationType.ease,
                value: entry.getPercentage.toDouble(),
                width: 18,
                enableAnimation: true,
                pointerOffset: -6,
                cornerStyle: CornerStyle.endCurve,
                color: const Color(0xFFF67280),
                gradient: const SweepGradient(
                    colors: <Color>[Colors.lightBlueAccent, Colors.greenAccent],
                    stops: <double>[0.25, 0.75]),
              ),
            ]),
      ],
    );
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
