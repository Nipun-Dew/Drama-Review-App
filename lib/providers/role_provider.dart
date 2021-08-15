// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';

// import '../models/roles.dart';

// class Roles with ChangeNotifier {
//   List<Role> _items = [
//     ///////////////////////////////////////////////Directors/////////////////////////////////////////////////////
//     Role(starID: "Sajitha Anthoney", role: "director", imageUrl: "https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"),
//     Role(starID: "Kokila Pawan", role: "director", imageUrl: "https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"),
//     Role(starID: "Giriraj Kaushalya", role: "director", imageUrl: "https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"),

//     ///////////////////////////////////////////////Producers/////////////////////////////////////////////////////
//     Role(starID: "Sajitha Anthoney", role: "producer", imageUrl: "https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"),
//     Role(starID: "Kokila Pawan", role: "producer", imageUrl: "https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"),
//     Role(starID: "Giriraj Kaushalya", role: "producer", imageUrl: "https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"),

//     ///////////////////////////////////////////////Actors/////////////////////////////////////////////
//     Role(starID: "Sajitha Anthoney", role: "Sara", imageUrl: "https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"),
//     Role(starID: "Kokila Pawan", role: "Malan", imageUrl: "https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"),
//     Role(starID: "Giriraj Kaushalya", role: "Kabral", imageUrl: "https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"),
//     Role(starID: "Senali Fonseka", role: "Patali", imageUrl: "http://news.starfriends.lk/wp-content/uploads/2018/04/19510250_1148843151928007_3508492931387696191_n-1-780x405.jpg"),
//     Role(starID: "Praveena Disanayake", role: "Geethika", imageUrl: "https://1.bp.blogspot.com/-l8RK9DWoquk/YDOLvIQU1II/AAAAAAAAD6U/2L8Ij9HgvE4DRvUQx27F-4j3mj3TYXvQQCLcBGAsYHQ/s320/IMG-20210217-WA0007.jpg"),
//     Role(starID: "Kalani Dodantenna", role: "Amasha", imageUrl: "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg"),
//     Role(starID: "Danuka Dilshan", role: "Deeptha", imageUrl: "https://1.bp.blogspot.com/-l4BoDEbYqPM/XqSuJlrnYhI/AAAAAAAABvw/3H0uYZL0HmY8kai04EyI5--6mcGoZtjfgCLcBGAsYHQ/s1600/1.jpg"),
//     Role(starID: "Hemasiri Liyanage", role: "Deepthas Father", imageUrl: "https://1.bp.blogspot.com/-hG6opbeoRa0/XqSuK_NgjzI/AAAAAAAABv4/fFdH2d4L4agvA-UNIrR_pyPLi3KZgj94QCLcBGAsYHQ/s1600/3.jpg"),
//     Role(starID: "Yashoda Wimalaweera", role: "Yashoda", imageUrl: "https://1.bp.blogspot.com/-6J_odCK2IPs/XqSuKhK6jTI/AAAAAAAABv0/3VEmAYxK2Yo81LU8AtNYslmPD0LcGpLwACLcBGAsYHQ/s1600/2.JPG"),
//   ];

//   List<Role> get items {
//     return [..._items];
//   }

// }



// Item(
    //     id: "I1",
    //     category: "C1",
    //     title: "Nadagamkarayo",
    //     imageUrls: [
    //       "https://steemitimages.com/p/TZjG7hXReeVoAvXt2X6pMxYAb3q65xMju8wryWxKrsghkLoEqpouqCt7QGaJSv8qX8FaMW8RPeeL3tyhpXaTGBZSDLGft3WXaxBBR9fFksjUiNZH9wsBe3nTQye4TPJHqPiCs7bCHDF2W2?format=match&mode=fit&width=800",
    //       "https://i2.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-130.jpg?fit=300%2C171&ssl=1",
    //       "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-129.jpg?fit=300%2C171&ssl=1",
    //       "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-131.jpg?fit=300%2C172&ssl=1"
    //     ],
    //     description:
    //         "Nadagamkarayo is a drama based on a village life. Sara, Kiriputha, Kawadiya, Sudda are four young boys who sell toddy for living. Master is the musician in that village. First half of the story goes with the Vesak drama which is produced by the Master. Kukula lakuna is the rowdy of that village who is determined to be a politician",
    //     cast: [
    //       {"role": "Sara", "starID": "Sajitha Anthoney"},
    //       {"role": "Malan", "starID": "Kokila Pawan"},
    //       {"role": "Kabral", "starID": "Giriraj Kaushalya"},
    //       {"role": "Patali", "starID": "Senali Fonseka"},
    //       {"role": "Geethika", "starID": "Praveena Disanayake"}
    //     ],
    //     directors: [
    //       {"role": "director", "starID": "Kokila Pawan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Giriraj Kaushalya"},
    //       {"role": "producer", "starID": "Sajitha Anthoney"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {
    //       "userId1": "Great Teledrama ❤️",
    //       "userId2": "Best Acting 🔥",
    //       "userId3": "kukulai kikili patiyai 😂😂😂",
    //       "userId4": "කැකුලා සරාගෙන් කනවා බලන්න ආස අය කෝ.. 😡",
    //       "userId5": "Amboo ape Malan aiyya dena athal nm..."
    //     },
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 0,
    //     youtubeURL: "https://www.youtube.com/watch?v=gMv_QGTX7OQ&list=RDgMv_QGTX7OQ&start_radio=1"),
    // Item(
    //     id: "I2",
    //     category: "C1",
    //     title: "Thnamalvila Kollek",
    //     imageUrls: [
    //       "https://i.ytimg.com/vi/nSe4hW60FNI/maxresdefault.jpg",
    //       "https://m.media-amazon.com/images/M/MV5BZDMzMGRlMmYtNmU1YS00Y2Y5LWEzMmItZjNjYjQ5ZjFhNzM2XkEyXkFqcGdeQXVyMTE3MTI4NTI2._V1_.jpg",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-26-2.jpg",
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKwtNQ7JWzugWVx__wcBa97phJ4TuAQV3K2nyU79s-UhrGigAz5Bhq471hHR70V_BFi34&usqp=CAU",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg"
    //     ],
    //     description:
    //         "Thnamalvila kollek a life story of a village boy who is struggeling with many problems as a person in a rural area. This teledrama shows how win his life and make a succefull artist. THis teledrama shows calm and peacefullnes of the village as well as the dark side of the village life as poverty and how people are strugling to win their lives",
    //     // cast: ["Deeptha - Dhanuka Dilshan", "kithula - Xavier Kanishka", "koora - Nilanka Sepala Dahanayake", "Yashodhara - Yashoda Wimaladharma"],
    //     cast: [
    //       {"role": "Amasha", "starID": "Kalani Dodantenna"},
    //       {"role": "Yashoda", "starID": "Yashoda Wimalaweera"},
    //       {"role": "Deeptha", "starID": "Danuka Dilshan"},
    //       {"role": "Deepthas Father", "starID": "Hemasiri Liyanage"}
    //     ],
    //     // director: "Roshan Ravindra",
    //     // producer: "Fahim Maujude",
    //     directors: [
    //       {"role": "director", "starID": "Sajitha Anthoney"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Kokila Pawan"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {"userId1": "Great story", "userId2": "Superb camera shots"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=L4DRwfjjnCw"),
    // Item(
    //     id: "I3",
    //     category: "C2",
    //     title: "Agoha",
    //     imageUrls: ["https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg"],
    //     description: "Agohsa is a.....",
    //     cast: [],
    //     // director: "Director",
    //     // producer: "Producer",
    //     directors: [
    //       {"role": "director", "starID": "Jayaprakash Sivagurunadan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Chamara Samarawickrama"}
    //     ],
    //     genres: ["Thriller"],
    //     reviews: {"userId1": "Waiting for Episode2", "userId2": "Good initiative"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=esU2KhThkzc"),
    // Item(
    //     id: "I4",
    //     category: "C3",
    //     title: "Machan",
    //     imageUrls: ["https://m.media-amazon.com/images/M/MV5BMzZhN2YxYWEtMjY0Mi00NWRhLWE0ZjktMDM1ZWI5ZTA4MTE5XkEyXkFqcGdeQXVyNTA3MDM5MTM@._V1_.jpg"],
    //     description: "Machan is a movie.....",
    //     cast: [],
    //     //
    //     directors: [
    //       {"role": "director", "starID": "Jayaprakash Sivagurunadan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Chamara Samarawickrama"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {"userId1": "hahahaaaa", "userId2": "mara dial tikk neh mun"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=kW9ijxpZc-0"),
