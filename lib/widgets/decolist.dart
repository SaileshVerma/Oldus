import 'package:flutter/material.dart';
import 'package:oldies/models/data.dart';

import 'package:oldies/widgets/grids.dart';

class DecoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Data.map(
          (i) => DecoGrid(
            col: i.col,
            imgpath: i.imgpath,
            quote: i.quote,
          ),
        ).toList(),
      ),
    );
  }
}
