import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menon_health_tech/constants/app_colors.dart';
import 'package:menon_health_tech/firebase/db.dart';
import 'package:menon_health_tech/widgets/Loading.dart';

class NavigationDrawerHeader extends StatelessWidget {
  final String phone;
  NavigationDrawerHeader(this.phone);
//
//    var profileImage = new Image(
//      image: new AssetImage('Images/profile picture.jpg'),
//      height: 300,
//      width: 200);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: primaryColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: new AssetImage('Images/profile picture.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 20),
            child: GestureDetector(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder(
                          future: DB().getUser(phone),
                          builder: (BuildContext context,
                              AsyncSnapshot asyncSnapshot) {
                            if (asyncSnapshot.data == null) {
                              return Loading();
                            } else {
                              return Text(asyncSnapshot.data.firstName +
                                  " " +
                                  asyncSnapshot.data.lastName);
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'User Profile',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              onTap: () {
                //Go to profile page for completion
              },
            ),
          ),
        ],
      ),
    );
  }
}
