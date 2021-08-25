import 'package:flutter/material.dart';

import 'package:hello_inside_task/screens/home_screen/chart_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:hello_inside_task/screens/home_screen/grouped_view.dart';
import 'package:hello_inside_task/screens/home_screen/spikes_view.dart';

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

  int _index = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [GroupedView(), SpikesView(), ChartView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _index = index),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: 'Grouped view',
            icon: Icon(
              Icons.list,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Spikes view',
            icon: Icon(
              Icons.warning,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Charts view',
            icon: Icon(
              Icons.add_chart,
            ),
          ),
        ],
      ),
    );
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

      /* BlocConsumer<SensorCubit, SensorState>(
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
    ));*/