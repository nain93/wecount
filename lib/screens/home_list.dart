import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/types/color.dart';
import 'package:flutter/material.dart';
import 'package:wecount/models/user.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/home_header_search.dart' show HomeHeaderSearch;
import 'package:wecount/models/category.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/widgets/home_list_item.dart';

import 'package:wecount/utils/localization.dart';
import 'package:intl/intl.dart';
import 'package:wecount/utils/asset.dart' as Asset;

import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

class HomeList extends StatefulWidget {
  HomeList({
    Key? key,
  }) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  TextEditingController textEditingController = TextEditingController();

  var _data = [];
  var _listData = [];

  // List<List<LedgerItem>> _ledgerItems = [[]];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var _localization = Localization.of(context)!;

      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 8,
              label: _localization.trans('EXERCISE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );
      _data.add(
        LedgerItem(
          price: 300000,
          category: Category(
              iconId: 18,
              label: _localization.trans('WALLET_MONEY'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 10),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: 'engela lee'),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: 300000,
          category: Category(
              iconId: 18,
              label: _localization.trans('WALLET_MONEY'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 8),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: '이범주'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );

      _data.add(
        LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: User(uid: 'who1@gmail.com', displayName: 'mizcom'),
          selectedDate: DateTime(2019, 9, 6),
        ),
      );
      _data.add(
        LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItem(
          price: -2100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );
      _data.add(
        LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: DateTime(2019, 9, 4),
        ),
      );

      // sort data
      _data.sort((a, b) {
        return a.selectedDate.compareTo(b.selectedDate);
      });

      // insert Date row as Header
      DateTime? prevDate;
      var temp = [];
      for (var i = 0; i < _data.length; i++) {
        if (prevDate != _data[i].selectedDate) {
          // 다르면 모은 데이터를 저장하고, 모음 리셋
          if (temp.length > 0) {
            _listData.add({
              'date': prevDate,
              'ledgerItems': temp,
            });
          }
          prevDate = _data[i].selectedDate;
          temp = [];
        }
        temp.add(_data[i]); // 데이터 임시 모음
        // _listData.add(_data[i]);
      }
      if (temp.length > 0) {
        _listData.add({
          'date': prevDate,
          'ledgerItems': temp,
        });
      }
    });
  }

  Widget _renderListHeader(DateTime date) {
    String headerString = DateFormat('yyyy-MM-dd (E)').format(date);
    return Container(
      height: 60.0,
      padding: EdgeInsets.only(
        top: 16.0,
        left: 10.0,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        headerString,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.displayMedium!.color,
        ),
      ),
    );
  }

  List<Widget> _renderList(BuildContext context) {
    return List.generate(_listData.length, (index) {
      var section = _listData[index];
      var headerDate = section['date'];
      var ledgerItems = section['ledgerItems'];
      return SliverStickyHeader(
        header: _renderListHeader(headerDate),
        sliver: SliverList(
          key: Key(index.toString()),
          delegate: SliverChildBuilderDelegate(
            (context, i) => HomeListItem(ledgerItem: ledgerItems[i]),
            childCount: ledgerItems.length,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.DUSK;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        backgroundColor: Asset.Colors.getColor(color),
        title: HomeHeaderSearch(
          onPressAdd: () =>
              navigation.push(context, AppRoute.ledgerItemEdit.path),
          onPressDelete: () => textEditingController.clear(),
          color: Asset.Colors.getColor(color),
          margin: EdgeInsets.only(left: 20.0),
          textEditingController: textEditingController,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: _renderList(context),
          ),
        ),
      ),
    );
  }
}
