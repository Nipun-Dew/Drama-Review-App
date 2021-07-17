import 'package:flutter/material.dart';

import '../models/upcoming_drama.dart';

class DramaDetails with ChangeNotifier {
  List<UpcomingDrama> upcomingList = [
    UpcomingDrama("1", "Podhu season 2", "mini series", "Derana tv", "not available"),
    UpcomingDrama("2", "Agosha", "web series", "channel4", "not available"),
    UpcomingDrama("3", "Chalo", "tv series", "Swarnawahini", "weekdays 9pm"),
    UpcomingDrama("4", "Sabanda Pabilis", "old tv series", "Rupawahini", "weekends 7pm"),
    UpcomingDrama("5", "Sarisara", "old tv documentry", "Rupawahini", "Friday 7pm"),
  ];
}