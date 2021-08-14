import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String msg;
  final String title;
  final BuildContext ctx;

  AlertBox(this.msg, this.title, this.ctx);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
              child: Text(
                msg,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ))),
      actions: [
        Center(
          child: Divider(
            thickness: 0.3,
            color: Colors.grey[600],
          ),
        ),
        Center(
          child: TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                "Close",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              )),
        )
      ],
    );
  }
}
