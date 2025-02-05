import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;
import 'package:wecount/screens/home_list.dart' show HomeList;
import 'package:wecount/screens/home_statistic/home_statistic.dart'
    show HomeStatistic;
import 'package:wecount/screens/home_setting.dart' show HomeSetting;

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    String _title = Provider.of<CurrentLedger>(context).getTitle() ?? '';

    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _index != 0,
            child: TickerMode(
              enabled: _index == 0,
              child: HomeCalendar(
                title: _title,
              ),
            ),
          ),
          Offstage(
            offstage: _index != 1,
            child: TickerMode(
              enabled: _index == 1,
              child: HomeList(),
            ),
          ),
          Offstage(
            offstage: _index != 2,
            child: TickerMode(
              enabled: _index == 2,
              child: HomeStatistic(title: _title),
            ),
          ),
          Offstage(
            offstage: _index != 3,
            child: TickerMode(
              enabled: _index == 3,
              child: HomeSetting(
                title: _title,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (int index) => setState(() => this._index = index),
        selectedItemColor: Theme.of(context).textTheme.displayLarge!.color,
        unselectedItemColor: Theme.of(context).textTheme.displayLarge!.color,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: Icon(
              Icons.calendar_today,
              size: 20.0,
            ),
            label: 'Monthly',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: Icon(
              Icons.list,
              size: 20.0,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: Icon(
              Icons.graphic_eq,
              size: 20.0,
            ),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: Icon(
              Icons.settings,
              size: 20.0,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
