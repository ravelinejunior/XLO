import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/screens/ad_screen/components/description_panel.dart';
import 'package:olx_project_parse/screens/ad_screen/components/main_panel.dart';

import 'components/ad_owner_panel.dart';
import 'components/location_panel.dart';

class AdScreen extends StatelessWidget {
  const AdScreen(this.ad);
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
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
              dotSize: 4,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                MainPanel(ad),
                Divider(color: Colors.grey[500]),
                DescriptionPanel(ad),
                Divider(color: Colors.grey[500]),
                LocationPanel(ad),
                Divider(color: Colors.grey[500]),
                AdOwnerPanel(ad),
                Divider(color: Colors.grey[500]),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
