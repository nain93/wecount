import 'package:flutter/material.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart' show Localization;

import '../widgets/home_header.dart' show renderHomeAppBar;

class MainEmpty extends StatefulWidget {
  const MainEmpty({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _MainEmptyState createState() => _MainEmptyState();
}

class _MainEmptyState extends State<MainEmpty> {
  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHomeAppBar(
        context: context,
        title: '',
        actions: [
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () => navigation.push(context, AppRoute.setting.path),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: Theme.of(context).primaryColorLight,
              size: 80,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 40,
                right: 40,
                top: 22,
                bottom: 32,
              ),
              child: Text(
                _localization.trans('NO_LEDGER_DESCRIPTION')!,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              backgroundColor: Colors.transparent,
              width: 160,
              height: 56,
              shapeBorder: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: BorderSide(
                    color: Theme.of(context).textTheme.displayMedium!.color!,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              onPress: () =>
                  Navigator.of(context).pushNamed(AppRoute.ledgerEdit.fullPath),
              text: _localization.trans('ADD_LEDGER'),
              textStyle: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
