import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';

import 'package:hello_inside_task/utils/extensions.dart';

class GroupedView extends StatefulWidget {
  @override
  _GroupedViewState createState() => _GroupedViewState();
}

class _GroupedViewState extends State<GroupedView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SensorCubit, SensorState>(
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

  Widget _buildLoadedData(SensorData sensorData) =>
      GroupedListView<Measurement, String>(
        elements: sensorData.measurements,
        groupBy: (Measurement element) => element.date.toDay,
        groupSeparatorBuilder: (String groupByValue) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            groupByValue,
            softWrap: true,
            style: TextStyle(fontSize: 25),
          ),
        ),
        itemBuilder: (context, dynamic element) => _renderItem(element),

        // optional
      );
  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
  Widget _buildError(String error) => Center(
        child: Text(error),
      );
  Widget _renderItem(Measurement e) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Text('at: ' + e.date.toTimeOfDay),
        trailing: Text(e.value.toString() + ' mg/dL'),
      ));
}
