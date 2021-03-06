import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/helpers/extensions.dart';

class SoldTile extends StatelessWidget {
  SoldTile(this.ad);
  final Ad ad;

  final List<MenuChoice> choices = [
    MenuChoice(
        index: 0,
        title: 'Excluir Anúncio',
        iconData: Icons.delete_forever_sharp),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        color: Colors.pink[700].withAlpha(200),
        height: MediaQuery.of(context).size.height / 5,
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.2,
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
                                color: Colors.black45),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black45.withAlpha(100),
                          ),
                          Text(
                            ad.price.formattedMoney(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black45),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black45.withAlpha(100),
                          ),
                          Text(
                            'PRODUTO VENDIDO!',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopupMenuButton<MenuChoice>(
                  icon: Icon(
                    Icons.more_vert_sharp,
                    size: 18,
                    color: Colors.black87,
                  ),
                  onSelected: (choice) {
                    switch (choice.index) {
                      case 0:
                        //case 0, delete
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
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  choice.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
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
          ],
        ),
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.iconData, this.title});
  final int index;
  final String title;
  final IconData iconData;
}
