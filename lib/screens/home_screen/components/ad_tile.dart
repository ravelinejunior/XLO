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
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        color: Colors.pink.withAlpha(150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Expanded(
          child: Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4.5,
                child: CachedNetworkImage(
                  imageUrl: adItem.images.isEmpty
                      ? 'https://preppykitchen.com/wp-content/uploads/2019/06/Ultimate-Chocolate-Cake-feature-1200-768x1089.jpg'
                      : adItem.images.last,
                  placeholder: (_, url) {
                    return Image.network(url);
                  },
                  fit: BoxFit.cover,
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
                        ),
                      ),
                      Text(
                        adItem.price.formattedMoney(),
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${adItem.dateCreated.formattedDate()} - '
                        '${adItem.address.city.name} - '
                        '${adItem.address.uf.initials}',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
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
