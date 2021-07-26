import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String comment;

  CommentItem({required this.comment});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 4,
//       margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
//       child: ListTile(
//         leading: Icon(
//           Icons.face,
//           size: 20,
//         ),
//         title: Text(
//           comment,
//           style: TextStyle(
//             fontFamily: 'RobotoCondensed',
//             fontSize: 18,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            // width: 30,
            child: Icon(
              Icons.face,
              size: 50,
            ),
          ),
          Container(
            width: 330,
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 2),
                    child: Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 3),
                    child: Text(
                      comment,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
