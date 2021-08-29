import 'package:drama_app/models/cast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cast_provider.dart';
import '../../models/cast.dart';
import '../../widgets/star_item_widget.dart';

class CinemaStarScreen extends StatefulWidget {
  @override
  _CinemaStarScreenState createState() => _CinemaStarScreenState();
}

class _CinemaStarScreenState extends State<CinemaStarScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Casts>(context, listen: false).getRoles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Cast> starsList = Provider.of<Casts>(context).items;
    return Provider.of<Casts>(context).isLoading
        ? Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: CircularProgressIndicator()),
          )
        : Column(
            children: [...starsList.map((cast) => StarItemWidget(cast))],
          );
  }
}
