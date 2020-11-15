import 'package:flutter/material.dart';
import 'package:oldies/widgets/city_grid.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/cities.dart';

class CityGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cities>(context, listen: false).citylist;
    // final slist = data.firstWhere((l) => l.city== ).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CityGrid(
          data[i].city,
          data[i].color,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3),
    );
  }
}
