import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/screens/ad_screen/ad_screen.dart';
import 'package:olx_project_parse/stores/favorite_store.dart';

class FavoriteTile extends StatelessWidget {
  FavoriteTile(this.ad);

  final Ad ad;
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad)));
      },
      child: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Row(
            children: [
              SizedBox(
                height: 135,
                width: 127,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
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
                        ad.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${ad.dateCreated.formattedDate()} - '
                              '${ad.address.city.name} - '
                              '${ad.address.uf.initials}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => favoriteStore.toggleFavorite(ad),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                              size: 20,
                            ),
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
      ),
    );
  }
}
