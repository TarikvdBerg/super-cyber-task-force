import 'package:flutter/material.dart';

class SideBarProfile extends StatelessWidget {
  const SideBarProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 15, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("John Doe",
                style: TextStyle(
                  color: Color(0xFFBEBEBE),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            Text("john.doe@isp.com",
                style: TextStyle(
                  color: Color(0xFFBEBEBE),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                )),
          ],
        )
        );
  }
}
