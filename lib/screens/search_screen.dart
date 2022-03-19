import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

import '../models/news_view.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key, @required this.Query}) : super(key: key);
  final String Query;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final String apiKey = 'apiKey=8059b98d617342a3885a4a44f35fea34';
  final String baseUrl = 'https://newsapi.org/v2';
  List<News> newsList = [];
  bool isLoading = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
    getNewsByQuery(widget.Query);
    //categories = getCategories();
  }

  Future getNewsByQuery(String query) async {
    Map element;
    int i = 0;
    String url = '$baseUrl/everything?q=$query&$apiKey';
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      //data['articles'].forEach((element) {
      for (element in data['articles']) {
        try {
          i++;
          News news = new News();
          news = News.fromMap(element);
          newsList.add(news);
          setState(() {
            isLoading = false;
          });
        } catch (error) {
          //print(error);
        }

        if (i == 12) {
          break;
        }
      }
    });
  }

  loadMore(String query) async {
    setState(() {
      page = page + 1;
    });
    String url = '$baseUrl/everything?q=$query&$apiKey&page=' + page.toString();
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data['articles'].forEach((element) {
        News news = new News();
        news = News.fromMap(element);
        newsList.add(news);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  try{
                  return Container(
                    child: InkWell(
                      onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsView(newsList[index].newsUrl),
                                          ));
                                    },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    //color: Colors.amber,
                                    width: 210,
                                    height: 120,
                                    child: Text(
                                      newsList[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  //color: Colors.amber,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.newspaper,
                                        color: Colors.red,
                                        size: 19,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 180,
                                        //color: Colors.green,
                                        child: Text(
                                          newsList[index].sourceName != null
                                              ? newsList[index].sourceName
                                              : 'Anonymus',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                height: 150,
                                width: 165,
                                //color: Colors.amber,
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                            //alignment: Alignment.center,
                                            height: 110,
                                            width: 138,
                                            child: Image.network(
                                              newsList[index].imageUrl != null
                                                  ? newsList[index].imageUrl
                                                  : Center(child: Text('...')),
                                              fit: BoxFit.fill,
                                            )),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                              onPressed: () {},
                                              color: Colors.white,
                                              icon: Icon(Icons.bookmark_add)),
                                        )
                                      ],
                                    )))
                          ],
                        ),
                      ),
                    ),
                  );
                  } catch (error) {
                                  print(error);
                                  return Container();
                                }
                }),
            Container(
              //color: Colors.amber,
              height: 40,
              child: ElevatedButton(
                onPressed: () => loadMore(widget.Query),
                child:
                    Text("SHOW MORE", style: TextStyle(color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
