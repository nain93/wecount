import 'package:wecount/providers/current_ledger.dart';
import 'package:flutter/material.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/screens/members.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/member_horizontal_list.dart';
import 'package:wecount/services/database.dart' show DatabaseService;
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/types/color.dart';
import 'package:provider/provider.dart';

class LedgerEditArguments {
  final Ledger? ledger;
  final LedgerEditMode mode;

  LedgerEditArguments({this.ledger, this.mode = LedgerEditMode.ADD});
}

enum LedgerEditMode {
  ADD,
  UPDATE,
}

class LedgerEdit extends StatefulWidget {
  final Ledger? ledger;
  final LedgerEditMode mode;

  const LedgerEdit({
    Key? key,
    this.ledger,
    this.mode = LedgerEditMode.ADD,
  }) : super(key: key);

  @override
  _LedgerEditState createState() => _LedgerEditState(this.ledger, this.mode);
}

class _LedgerEditState extends State<LedgerEdit> {
  Ledger? _ledger;
  bool _isLoading = false;

  _LedgerEditState(Ledger? ledger, LedgerEditMode mode) {
    if (ledger == null) {
      _ledger = Ledger(
        title: '',
        currency: currencies[29],
        color: ColorType.DUSK,
        adminIds: [],
        memberIds: [],
      );
      return;
    }
    _ledger = ledger;
  }

  void _onPressCurrency() async {
    var _result = await navigation.navigate(
      context,
      AppRoute.settingCurrency.path,
      arguments: SettingCurrencyArguments(
        selectedCurrency: _ledger!.currency.currency,
      ),
    );

    if (_result == null) return;

    setState(() => _ledger!.currency = _result);
  }

  void _selectColor(ColorType item) {
    setState(() => _ledger!.color = item);
  }

  void _pressDone() async {
    final _db = DatabaseService();

    setState(() => _isLoading = true);

    if (_ledger!.title.isEmpty) {
      print('title is null');
      return;
    }

    if (_ledger!.description == null || _ledger!.description!.isEmpty) {
      print('description is null');
      return;
    }

    if (widget.mode == LedgerEditMode.ADD) {
      try {
        await _db.requestCreateNewLedger(_ledger);
      } catch (err) {
        print('err: $err');
      } finally {
        setState(() => _isLoading = false);
      }

      Navigator.of(context).pop();
    } else if (widget.mode == LedgerEditMode.UPDATE) {
      try {
        await _db.requestUpdateLedger(_ledger);
      } catch (err) {
        print('err: $err');
      } finally {
        setState(() => _isLoading = false);
      }

      Navigator.of(context).pop();
    }
  }

  void _leaveLedger() async {
    bool hasLeft = await DatabaseService().requestLeaveLedger(_ledger!.id);

    if (hasLeft) {
      var ledger = await DatabaseService().fetchSelectedLedger();
      Provider.of<CurrentLedger>(context, listen: false).setLedger(ledger);
      Navigator.of(context).pop();
    }

    var _localization = Localization.of(context)!;

    navigation.showSingleDialog(
      context,
      title: Text(_localization.trans('ERROR')!),
      content: Text(_localization.trans('SHOULD_TRANSFER_OWNERSHIP')!),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;

    return Scaffold(
      backgroundColor: Asset.Colors.getColor(_ledger!.color),
      appBar: renderHeaderBack(
        context: context,
        brightness: Brightness.dark,
        actions: [
          Container(
            width: 56.0,
            margin: EdgeInsets.only(right: 16),
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: _leaveLedger,
              child: Text(
                _localization.trans('LEAVE')!,
                semanticsLabel: _localization.trans('LEAVE'),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                  child: TextField(
                    maxLines: 1,
                    onChanged: (String txt) {
                      _ledger!.title = txt;
                    },
                    controller: TextEditingController(text: _ledger!.title),
                    decoration: InputDecoration(
                      hintMaxLines: 2,
                      border: InputBorder.none,
                      hintText: _localization.trans('LEDGER_NAME_HINT'),
                      hintStyle: TextStyle(
                        fontSize: 28.0,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 24, left: 40, right: 40, bottom: 20),
                  height: 160,
                  child: TextField(
                    maxLines: 8,
                    onChanged: (String txt) {
                      _ledger!.description = txt;
                    },
                    controller:
                        TextEditingController(text: _ledger!.description),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _localization.trans('LEDGER_DESCRIPTION_HINT'),
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: _onPressCurrency,
                  child: Container(
                    height: 80.0,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 40.0, right: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _localization.trans('CURRENCY')!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${_ledger!.currency.currency} | ${_ledger!.currency.symbol}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.chevron_right,
                                size: 16,
                                color: Color.fromRGBO(255, 255, 255, 0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white70),
                Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          _localization.trans('COLOR')!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 32),
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: colorItems.length,
                            itemExtent: 32,
                            itemBuilder: (context, index) {
                              final item =
                                  colorItems[colorItems.length - index - 1];
                              bool selected = item == _ledger!.color;
                              return ColorItem(
                                color: item,
                                onTap: () => _selectColor(item),
                                selected: selected,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.white70),
                MemberHorizontalList(
                  showAddBtn: true,
                  memberIds:
                      widget.ledger != null ? widget.ledger!.memberIds : [],
                  onSeeAllPressed: () => navigation.navigate(
                    context,
                    AppRoute.members.path,
                    arguments: MembersArguments(ledger: widget.ledger),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: SizedBox(
                // width: 120,
                height: 60,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                    ),
                  ),
                  onPressed: _pressDone,
                  child: _isLoading
                      ? Container(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            semanticsLabel:
                                Localization.of(context)!.trans('LOADING'),
                            backgroundColor: Theme.of(context).primaryColor,
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          widget.ledger == null
                              ? _localization.trans('DONE')!
                              : _localization.trans('UPDATE')!,
                          style: TextStyle(
                            color: Asset.Colors.getColor(_ledger!.color),
                            fontSize: 16.0,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  ColorItem({
    Key? key,
    this.color,
    this.selected,
    this.onTap,
  }) : super(key: key);
  final ColorType? color;
  final bool? selected;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipOval(
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: Asset.Colors.getColor(color),
            child: InkWell(
              onTap: onTap as void Function()?,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        selected == true
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : Container()
      ],
    );
  }
}
