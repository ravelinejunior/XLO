import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/helpers/extensions.dart';

class ActiveTile extends StatelessWidget {
  const ActiveTile(this.ad);
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        color: Colors.pink[700].withAlpha(200),
        height: MediaQuery.of(context).size.height / 5,
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.height / 5,
              /*  child: Carousel(
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
                autoplayDuration: Duration(seconds: 10),
              ), 
              */

              child: CachedNetworkImage(
                imageUrl: ad.images.isEmpty ? '' : ad.images.first,
                fit: BoxFit.cover,
                placeholder: (_, url) {
                  return FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.gif',
                    image: url,
                    fit: BoxFit.cover,
                    imageCacheHeight: 300,
                    imageCacheWidth: 300,
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ad.title,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Text(
                            ad.price.formattedMoney(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Text(
                            '${ad.views} Visitas ',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
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
    );
  }
}
