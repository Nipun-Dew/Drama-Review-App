import 'package:drama_app/models/cast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cast_provider.dart';
import '../../models/cast.dart';
import '../../widgets/star_item_widget.dart';

class CinemaStarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Cast> starsList = Provider.of<Casts>(context).items;

    return Column(
      children: [
        ...starsList.map((cast) => StarItemWidget(cast))
      ],
    );
  }
}
