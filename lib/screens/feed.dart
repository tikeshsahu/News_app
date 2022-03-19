import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_view.dart';
import 'package:news_app/screens/search_screen.dart';
import '../models/news.dart';

class Feed extends StatefulWidget {
  Feed({Key key, @required this.Query}) : super(key: key);
  String Query;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  TextEditingController searchController = new TextEditingController();
  final String apiKey = 'apiKey=8059b98d617342a3885a4a44f35fea34';
  final String baseUrl = 'https://newsapi.org/v2';
  bool isLoading = true;
  List<News> newsList = [];
  List<News> newsListSlider = [];
  int page = 1;
  //List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    getNewsByQuery(widget.Query);
    //categories = getCategories();
    newsForSlider();
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

        if (i == 10) {
          break;
        }
      }
    });
  }

  Future newsForSlider() async {
    String url = '$baseUrl/everything?q=India&$apiKey';
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data['articles'].forEach((element) {
        News news = new News();
        news = News.fromMap(element);
        newsListSlider.add(news);
        setState(() {
          isLoading = false;
        });
      });
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
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                //Search Container
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 8),
                //   margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(24)),
                //   child: Row(
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           if ((searchController.text).replaceAll(" ", "") ==
                //               "") {
                //             print("Blank search");
                //           } else {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SearchResult(
                //                           Query: searchController.text,
                //                         )));
                //           }
                //         },
                //         child: Container(
                //           child: Icon(
                //             Icons.search,
                //             color: Colors.pink,
                //           ),
                //           margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                //         ),
                //       ),
                //       Expanded(
                //         child: TextField(
                //           controller: searchController,
                //           textInputAction: TextInputAction.search,
                //           onSubmitted: (value) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SearchResult(
                //                           Query: value,
                //                         )));
                //           },
                //           decoration: InputDecoration(
                //               border: InputBorder.none, hintText: "Search"),
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                // Container(

                //     /// category container
                //     padding: EdgeInsets.symmetric(horizontal: 16),
                //     height: 75,
                //     child: ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemCount: categories.length,
                //         itemBuilder: (context, index) {
                //           return CategoryTileHP(
                //             categoryName: categories[index].categoryName,
                //             imageUrl: categories[index].imageUrl,
                //           );
                //         })),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: isLoading == false
                        ? CarouselSlider(
                            options: CarouselOptions(
                                height: 210,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.8,
                                autoPlayCurve: Curves.fastOutSlowIn),
                            items: newsListSlider.map((khabar) {
                              return Builder(builder: (BuildContext context) {
                                try {
                                  return Container(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewsView(khabar.newsUrl),
                                          ));
                                    },
                                    child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                khabar.imageUrl,
                                                fit: BoxFit.cover,
                                                height: double.infinity,
                                              )),
                                          Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 10),
                                                    child: Text(
                                                      khabar.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              )),
                                        ])),
                                  ));
                                } catch (error) {
                                  print(error);
                                  return Container();
                                }
                              });
                            }).toList(),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "LATEST NEWS ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            try {
                              return Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewsView(newsList[index].newsUrl),
                                        ));
                                  },
                                  child: Card(
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                //color: Colors.amber,
                                                width: 210,
                                                height: 120,
                                                child: Text(
                                                  newsList[index].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    newsList[index]
                                                                .sourceName !=
                                                            null
                                                        ? newsList[index]
                                                            .sourceName
                                                        : 'Anonymus',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        //alignment: Alignment.center,
                                                        height: 110,
                                                        width: 138,
                                                        child: CachedNetworkImage(
                                                          placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                                                          imageUrl: newsList[index].imageUrl,
                                                          errorWidget: (context, url, error) => Center(child: Text('Loading....'),),
                                                          fit: BoxFit.fill,
                                                        ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          color: Colors.white,
                                                          icon: Icon(Icons
                                                              .bookmark_add)),
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
                          child: Text("SHOW MORE",
                              style: TextStyle(color: Colors.black54)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
