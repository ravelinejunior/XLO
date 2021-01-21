import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/screens/ad_screen/ad_screen.dart';
import 'package:olx_project_parse/screens/create_screen/create_screen.dart';
import 'package:olx_project_parse/stores/myads_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.ad, this.myAdsStore);
  final Ad ad;
  final MyAdsStore myAdsStore;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];
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
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          color: Colors.pink[700].withAlpha(200),
          height: MediaQuery.of(context).size.height / 4.5,
          child: Row(
            children: [
              SizedBox(
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Text(
                              ad.price.formattedMoney(),
                              style: TextStyle(
                                  fontSize: 18,
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
                                  fontSize: 14,
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
              PopupMenuButton<MenuChoice>(
                icon: Icon(
                  Icons.more_vert_sharp,
                  size: 18,
                  color: Colors.white,
                ),
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      //case 0, edit
                      editAd(context);
                      break;
                    case 1:
                      //case 1, sold
                      break;
                    case 2:
                      //case 2, delete
                      break;
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                itemBuilder: (_) {
                  return choices
                      .map(
                        (choice) => PopupMenuItem<MenuChoice>(
                          value: choice,
                          child: Row(
                            children: [
                              Icon(
                                choice.iconData,
                                size: 20,
                                color: Colors.purple,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                choice.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    //receive the 'true' passed on createdscreec
    final success = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CreateScreen(ad: ad),
    ));
    if (success != null && success) {
      //update the screen
      await myAdsStore.refresh();
    }
  }
}

class MenuChoice {
  MenuChoice({this.index, this.iconData, this.title});
  final int index;
  final String title;
  final IconData iconData;
}
