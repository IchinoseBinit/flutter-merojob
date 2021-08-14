import 'package:flutter/material.dart';
import 'package:flutter_merojob/constants.dart';
import 'package:flutter_merojob/screens/home/home_screen.dart';
import 'package:flutter_merojob/screens/offline_courses/offline_courses_screen.dart';
import 'package:flutter_merojob/screens/profile/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/images/profile.jpeg",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user_name),
                    Text(user_email),
                  ],
                )
              ],
            ),
          ),
          buildDrawerTile(
            Icons.home_outlined,
            "Home",
            () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),
          buildDrawerTile(
            Icons.web_outlined,
            "Visit Website",
            () async {
              await launch(
                user_website_url,
                enableJavaScript: true,
                forceWebView: true,
              );
            },
          ),
          buildDrawerTile(
            Icons.person_outlined,
            "Profile",
            () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          buildDrawerTile(
            Icons.file_download_outlined,
            "Offline Courses",
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OfflineCoursesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerTile(IconData iconData, String title, Function function) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () async {
        await function();
      },
    );
  }
}
