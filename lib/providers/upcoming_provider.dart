import 'package:flutter/material.dart';

import '../models/upcoming_drama.dart';

class DramaDetails with ChangeNotifier {
  List<UpcomingDrama> upcomingList = [
    UpcomingDrama(
        "1",
        "Podhu",
        "mini series",
        "Derana tv",
        "not available",
        "https://scontent.fcmb2-1.fna.fbcdn.net/v/t1.6435-9/128523900_103903318238845_6326240369313915518_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=174925&_nc_ohc=BYriL1U0PHsAX-Kpklu&_nc_ht=scontent.fcmb2-1.fna&oh=dbe3121a2e6703a11279710fa0711fa9&oe=61215C4C"),
    UpcomingDrama(
        "2",
        "Gaadi",
        "movie",
        "Cinema halls",
        "not available",
        "https://static.wixstatic.com/media/349c34_11afa68794434071be1a5c3cb65c256f~mv2.jpg/v1/fill/w_2500,h_3750,al_c/349c34_11afa68794434071be1a5c3cb65c256f~mv2.jpg"),
    UpcomingDrama(
        "3",
        "Thotamuna",
        "tv series",
        "YouTube",
        "not available",
        "https://i.ytimg.com/vi/iRBhfqVowg0/maxresdefault.jpg"),
    UpcomingDrama(
        "4",
        "Sakarma",
        "tv series",
        "itn",
        "weekends 7pm",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM9-6L2ApGU5j16C5t7t2e_Ht_5zmD5pKzLqs0RJdywBKI9_ZtDhCjnq8_OBusoEYMbB0&usqp=CAU"),
    UpcomingDrama(
        "5",
        "Snap",
        "tv series",
        "Swarnawahini",
        "Friday 7pm",
        "https://1.bp.blogspot.com/-YLxTjIo5EWg/YB7aluaDk6I/AAAAAAAACjU/Ot6dy2ElToAyLxqmlr3TNF1CqPvVs91PwCLcBGAsYHQ/s1594/snap.jpg"),
  ];
}
