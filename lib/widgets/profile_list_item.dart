import 'package:flutter/material.dart';
import 'package:wecount/utils/asset.dart' as Asset;

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    this.key,
    this.imgStr,
    this.displayName,
    this.email,
    this.onTap,
  });

  final Key? key;
  final String? imgStr;
  final String? displayName;
  final String? email;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28.0),
      padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          imgStr != null
              ? Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: TextButton(
                    onPressed: this.onTap as void Function()?,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                          placeholder: 'res/icons/icMask.png',
                          image: this.imgStr!),
                    ),
                  ),
                )
              : ClipOval(
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: Asset.Icons.icMask,
                      fit: BoxFit.cover,
                      width: 80.0,
                      height: 80.0,
                      child: InkWell(
                        onTap: this.onTap as void Function()?,
                      ),
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    displayName!,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    email!,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
