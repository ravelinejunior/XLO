import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(this.ad);
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                if (!ad.hidePhone)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        final phone =
                            ad.user.phone.replaceAll(RegExp('[^0-9]'), '');
                        launch('tel:$phone');
                      },
                      splashColor: Colors.deepOrange,
                      child: Container(
                        height: 24,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Ligar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black45),
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.red[900],
                    child: Container(
                      height: 24,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(color: Colors.grey[400]),
              ),
            ),
            height: 48,
            alignment: Alignment.center,
            child: Text(
              '${ad.user.name} (Anunciante)',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
