import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:readmore/readmore.dart';

class DescriptionPanel extends StatelessWidget {
  const DescriptionPanel(this.ad);
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            'Descrição',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(
            ad.description,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: '  Ver descrição completa',
            trimExpandedText: '   Ver menos',
            colorClickableText: Colors.purple,
            moreStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            lessStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
