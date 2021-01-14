import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/models/ad.dart';

class AdTile extends StatelessWidget {
  const AdTile({this.adItem});
  final Ad adItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      height: MediaQuery.of(context).size.height / 4.7,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        color: Colors.pink.withAlpha(150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.7,
              width: MediaQuery.of(context).size.height / 5,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: adItem.images.isEmpty
                    ? 'https://preppykitchen.com/wp-content/uploads/2019/06/Ultimate-Chocolate-Cake-feature-1200-768x1089.jpg'
                    : adItem.images.last,
                fit: BoxFit.cover,
                imageCacheHeight: 300,
                imageCacheWidth: 300,
                fadeInCurve: Curves.bounceOut,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      adItem.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Text(
                      adItem.price.formattedMoney(),
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Text(
                      '${adItem.dateCreated.formattedDate()} - '
                      '${adItem.address.city.name} - '
                      '${adItem.address.uf.initials}',
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
    );
  }
}
