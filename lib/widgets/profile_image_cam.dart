import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wecount/utils/asset.dart' as Asset;
import 'package:image_picker/image_picker.dart';

class ProfileImageCam extends StatelessWidget {
  final Function? selectGallery;
  final Function? selectCamera;
  final XFile? imgFile;
  final String? imgStr;

  ProfileImageCam({
    this.selectGallery,
    this.selectCamera,
    this.imgFile,
    this.imgStr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              Container(
                width: 88.0,
                height: 88.0,
                child: this.imgStr == null && this.imgFile == null
                    ? ClipOval(
                        child: Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: Asset.Icons.icMask,
                              fit: BoxFit.cover,
                              width: 80.0,
                              height: 80.0,
                              child: InkWell(
                                onTap: this.selectGallery as void Function()?,
                              ),
                            )))
                    : this.imgFile != null
                        ? Container(
                            child: TextButton(
                              onPressed: this.selectGallery as void Function()?,
                              child: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(this.imgFile!.path)),
                                radius: 80.0,
                              ),
                            ),
                          )
                        : Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: TextButton(
                              onPressed: this.selectGallery as void Function()?,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: 'res/icons/icMask.png',
                                    image: this.imgStr!),
                              ),
                            ),
                          ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                width: 36.0,
                height: 36.0,
                child: ClipOval(
                  child: TextButton(
                    onPressed: this.selectCamera as void Function()?,
                    child: Icon(
                      Icons.camera,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
