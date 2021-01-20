import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/screens/ad_screen/ad_screen.dart';

class AdTile extends StatelessWidget {
  const AdTile({this.adItem});
  final Ad adItem;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.pink,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AdScreen(adItem),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        height: MediaQuery.of(context).size.height / 4,
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
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 5,
                /* child:FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image: adItem.images.isEmpty
                      ? 'https://preppykitchen.com/wp-content/uploads/2019/06/Ultimate-Chocolate-Cake-feature-1200-768x1089.jpg'
                      : adItem.images.last,
                  fit: BoxFit.cover,
                  imageCacheHeight: 300,
                  imageCacheWidth: 300,
                  fadeInCurve: Curves.bounceOut,
                ), */
                child: Carousel(
                  images: adItem.images
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        adItem.title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Divider(
                        color: Colors.grey[100].withAlpha(100),
                        thickness: 1,
                      ),
                      Text(
                        adItem.price.formattedMoney(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Divider(
                        color: Colors.grey[100].withAlpha(100),
                        thickness: 1,
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
      ),
    );
  }
}
