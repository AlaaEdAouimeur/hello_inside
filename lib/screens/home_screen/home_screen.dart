import 'package:flutter/material.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SensorCubit _sensorCubit;
  @override
  void initState() {
    _sensorCubit = BlocProvider.of<SensorCubit>(context);
    _sensorCubit.loadSensorData();
    super.initState();
  }

  Widget _renderItem(Entry e) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        subtitle: Text(e.getPercentage.toString() + ' %'),
        title: Text(DateFormat('EEE, M/d/y').format(e.day)),
        leading: Text(e.countSpikes.length.toString()),
        children: e.countSpikes
            .map((e) => ListTile(
                  leading: Text(DateFormat(DateFormat.HOUR24_MINUTE)
                      .format(e.dateTimeRange.start)),
                  trailing: Text(e.spikeValue.toString()),
                ))
            .toList(),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SensorCubit, SensorState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is SensorLoading)
          return CircularProgressIndicator();
        else if (state is SensorLoaded) {
          return ListView.builder(
              itemCount: state.sensorData.entries.length,
              itemBuilder: (context, i) {
                return _renderItem(state.sensorData.entries[i]);
              });
        } else if (state is SensorError)
          return Text(state.message);
        else
          return Text('idle');
      },
    ));
  }
}
/*GroupedListView<dynamic, String>(
        elements: entries.entries,
        groupBy: (element) => DateFormat('EEE, M/d/y').format(element.date),
        groupSeparatorBuilder: (String groupByValue) => Text(
          groupByValue,
          style: TextStyle(fontSize: 25),
        ),
        itemBuilder: (context, dynamic element) => _renderItem(element),

        useStickyGroupSeparators: true, // optional
        floatingHeader: true, // optional
      ),*/