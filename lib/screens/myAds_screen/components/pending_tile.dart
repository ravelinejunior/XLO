import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/screens/ad_screen/ad_screen.dart';

class PendingTile extends StatelessWidget {
  PendingTile(this.ad);
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.pinkAccent,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AdScreen(ad),
        ),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          color: Colors.pink[700].withAlpha(200),
          height: MediaQuery.of(context).size.height / 4.3,
          child: Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.3,
                width: MediaQuery.of(context).size.height / 5,
                child: Carousel(
                  images: ad.images
                      .map(
                        (url) => FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image: url,
                          fit: BoxFit.cover,
                          imageCacheHeight: 300,
                          imageCacheWidth: 300,
                        ),
                      )
                      .toList(),
                  indicatorBgPadding: 5,
                  dotSpacing: 10,
                  dotSize: 2,
                  borderRadius: true,
                  radius: Radius.circular(0),
                  dotColor: Colors.black,
                  dotIncreaseSize: 3,
                  dotIncreasedColor: Colors.deepOrange,
                  dotBgColor: Colors.transparent,
                  dotHorizontalPadding: 5,
                  autoplay: true,
                  autoplayDuration: Duration(seconds: 15),
                ),

                /* child: CachedNetworkImage(
                  imageUrl: ad.images.isEmpty ? '' : ad.images.first,
                  fit: BoxFit.cover,
                ), */
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ad.title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[100].withAlpha(100),
                            ),
                            Text(
                              ad.price.formattedMoney(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[100].withAlpha(100),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.timer,
                                    color: Colors.orange, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'AGUARDANDO PUBLICAÇÃO',
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
