import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(
            Radius.circular(15),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return InkWell(
              splashColor: Colors.pink,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey.withAlpha(100),
                  child: Icon(
                    Icons.camera_enhance,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                if (Platform.isAndroid) {
                  showModalBottomSheet(context: context, builder: null);
                } else if (Platform.isIOS) {
                  showCupertinoModalPopup(context: context, builder: null);
                } else {}
              },
            );
          },
          itemCount: 10,
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
