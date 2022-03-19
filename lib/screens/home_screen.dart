import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/drawer.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/feed.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: DefaultTabController(
        length: 7,
        child: Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Top   ',),
                Tab(text: 'World    '),
                Tab(text: 'Stock market  '),
                Tab(text: 'Business    '),
                Tab(text: 'Sports    '),
                Tab(text: 'Health    '),
                Tab(text: 'Technology   '),
              ],
            ),
            title: Text('The times of tilda'.toUpperCase(),
                style: TextStyle(fontFamily: GoogleFonts.aleo().fontFamily)),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.search)
              )
            ],
          ),
          body: TabBarView(
            children:  [
              Feed(Query: 'latest'),
              Feed(Query: 'world'),
              Feed(Query: 'stockmarket'),
              Feed(Query: 'business'),
              Feed(Query: 'sports'),
              Feed(Query: 'health'),
              Feed(Query: 'technology'),
            ],
          ),
        ),
      ),
    );
  }
}


