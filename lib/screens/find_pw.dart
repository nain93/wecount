import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/utils/navigation.dart';

import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;

class FindPw extends StatefulWidget {
  const FindPw({Key? key}) : super(key: key);

  @override
  _FindPwState createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  Localization? _localization;
  String _email = '';
  String? _errorEmail;

  bool _isValidEmail = false;
  bool _isSendingEmail = false;

  void _findPw() async {
    bool isEmail = Validator.instance.validateEmail(_email);

    if (!isEmail) {
      setState(() => _errorEmail = _localization!.trans('NO_VALID_EMAIL'));
      return;
    }

    setState(() => _isSendingEmail = true);

    try {
      await _auth.sendPasswordResetEmail(email: _email);
      navigation.showSingleDialog(
        context,
        title: Text(_localization!.trans('SUCCESS')!),
        content: Text(_localization!.trans('PASSWORD_RESET_LINK_SENT')!),
      );
    } catch (err) {
      print('error occured: ${err.toString()}');
    } finally {
      setState(() => _isSendingEmail = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _localization = Localization.of(context);

    Widget findPwText() {
      return Text(
        _localization!.trans('FIND_PASSWORD')!,
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget emailField() {
      return EditText(
        key: Key('email'),
        errorText: _errorEmail,
        margin: EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization!.trans('EMAIL'),
        textHint: _localization!.trans('EMAIL_HINT'),
        hasChecked: _isValidEmail,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            setState(() {
              _isValidEmail = true;
              _errorEmail = null;
            });
          } else {
            setState(() => _isValidEmail = false);
          }
          _email = str;
        },
        onSubmitted: (String str) => _findPw(),
      );
    }

    Widget sendButton() {
      return Button(
        key: Key('sendButton'),
        onPress: _findPw,
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        isLoading: _isSendingEmail,
        borderColor: Theme.of(context).primaryIconTheme.color,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization!.trans('SEND_EMAIL'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        elevation: 0.0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding:
                  const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    findPwText(),
                    emailField(),
                    sendButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
