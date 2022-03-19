import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SafeArea(
              child: Container(
            height: 240,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 85,
                 
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.lato().fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.category_outlined,
              color: Colors.grey,
            ),
            onTap: () {
             
            },
            title: Text('Shop',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600])),
          ),
          Divider(
            color: Colors.grey[500],
            height: 12,
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check),
            title: Text(
              'Orders',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            onTap: () {
              
            },
          ),
          Divider(
            color: Colors.grey[500],
            height: 15,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Products',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            onTap: () {
              
            },
          ),
          Divider(
            color: Colors.grey[500],
            height: 12,
          ),
          //
          ListTile(
            leading: Icon(Icons.playlist_add_check),
            title: Text(
              'start_page',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(WelcomePage.routeName);
            },
          ),
          ////
          Divider(
            color: Colors.grey[500],
            height: 12,
          ),
          //
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Log out',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
