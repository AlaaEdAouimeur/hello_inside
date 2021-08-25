import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:hello_inside_task/utils/extensions.dart';

class SpikesView extends StatefulWidget {
  @override
  _SpikesViewState createState() => _SpikesViewState();
}

class _SpikesViewState extends State<SpikesView> {
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

  Widget _buildLoadedData(SensorData sensorData) => ListView.builder(
      itemCount: sensorData.entries.length,
      itemBuilder: (context, i) {
        return _renderItem(sensorData.entries[i]);
      });
  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
  Widget _buildError(String error) => Center(
        child: Text(error),
      );
  Widget _renderItem(Entry e) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        subtitle: Text(e.getPercentage.toString() + ' %'),
        title: Text(e.day.toDay),
        leading: Text(e.countSpikes.length.toString()),
        children: e.countSpikes
            .map((e) => ListTile(
                  leading: Text('From:' +
                      e.dateTimeRange.start.toTimeOfDay +
                      '  To: ' +
                      e.dateTimeRange.end.toTimeOfDay),
                  trailing: Text('Spike value: ' + e.spikeValue.toString()),
                ))
            .toList(),
      ));
}
