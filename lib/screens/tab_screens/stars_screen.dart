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
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration.zero).then((_) {
      Provider.of<Casts>(context, listen: false).getRoles().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Cast> starsList = Provider.of<Casts>(context).items;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [...starsList.map((cast) => StarItemWidget(cast))],
          );
  }
}
