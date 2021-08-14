import 'package:flutter/material.dart';

import '../models/upcoming_drama.dart';

class DramaDetails with ChangeNotifier {
  List<UpcomingDrama> upcomingList = [
    UpcomingDrama(
        "1", "Podhu", "mini series", "Derana tv", "not available", "https://m.media-amazon.com/images/M/MV5BOTdhODUxMDAtZjllMS00MDEzLTlkMTAtODBhYWI2MGY4YmM4XkEyXkFqcGdeQXVyMTI3ODU5ODY5._V1_.jpg"),
    UpcomingDrama(
        "2", "Gaadi", "movie", "Cinema halls", "not available", "https://m.media-amazon.com/images/M/MV5BOTdhODUxMDAtZjllMS00MDEzLTlkMTAtODBhYWI2MGY4YmM4XkEyXkFqcGdeQXVyMTI3ODU5ODY5._V1_.jpg"),
    UpcomingDrama(
        "3", "Thotamuna", "tv series", "YouTube", "not available", "https://m.media-amazon.com/images/M/MV5BOTdhODUxMDAtZjllMS00MDEzLTlkMTAtODBhYWI2MGY4YmM4XkEyXkFqcGdeQXVyMTI3ODU5ODY5._V1_.jpg"),
    UpcomingDrama(
        "4", "Sakarma", "tv series", "itn", "weekends 7pm", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM9-6L2ApGU5j16C5t7t2e_Ht_5zmD5pKzLqs0RJdywBKI9_ZtDhCjnq8_OBusoEYMbB0&usqp=CAU"),
    UpcomingDrama(
        "5", "Snap", "tv series", "Swarnawahini", "Friday 7pm", "https://m.media-amazon.com/images/M/MV5BOTdhODUxMDAtZjllMS00MDEzLTlkMTAtODBhYWI2MGY4YmM4XkEyXkFqcGdeQXVyMTI3ODU5ODY5._V1_.jpg"),
  ];
}
