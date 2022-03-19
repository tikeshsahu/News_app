// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:news_app/api_service.dart';
// import 'package:news_app/models/categoriesHP.dart';

// import '../models/news.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController searchController = new TextEditingController();
//   final String apiKey = 'apiKey=8059b98d617342a3885a4a44f35fea34';
//   final String baseUrl = 'https://newsapi.org/v2';
//   bool isLoading = true;
//   List<News> newsList = [];
//   List<News> newsListSlider = [];
//   List<CategoryModel> categories = new List<CategoryModel>();

//   @override
//   void initState() {
//     super.initState();
//     getNewsByQuery();
//     categories = getCategories();
//     getTopHeadlinesIndia();
//   }

//   Future getNewsByQuery() async {
//     String url = '$baseUrl/everything?q=world&$apiKey';
//     final response = await http.get(Uri.parse(url));
//     Map data = jsonDecode(response.body);
//     setState(() {
//       data['articles'].forEach((element) {
//         News news = new News();
//         news = News.fromMap(element);
//         newsList.add(news);
//         setState(() {
//           isLoading = false;
//         });
//       });
//     });
//   }

//   Future getTopHeadlinesIndia() async {
//     String url = '$baseUrl/top-headlines?country=in&$apiKey';
//     final response = await http.get(Uri.parse(url));
//     Map data = jsonDecode(response.body);
//     setState(() {
//       data['articles'].forEach((element) {
//         News news = new News();
//         news = News.fromMap(element);
//         newsListSlider.add(news);
//         setState(() {
//           isLoading = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 233, 229, 229),
//       appBar: AppBar(
//         title: Text("Tilda_times"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               //Search Container

//               padding: EdgeInsets.symmetric(horizontal: 8),
//               margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(24)),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       if ((searchController.text).replaceAll(" ", "") == "") {
//                         print("Blank search");
//                       } else {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
//                       }
//                     },
//                     child: Container(
//                       child: Icon(
//                         Icons.search,
//                         color: Colors.pink,
//                       ),
//                       margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: searchController,
//                       textInputAction: TextInputAction.search,
//                       onSubmitted: (value) {
//                         print(value);
//                       },
//                       decoration: InputDecoration(
//                           border: InputBorder.none, hintText: "Search"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Container(

//                 /// category container
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 height: 75,
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       return CategoryTileHP(
//                         categoryName: categories[index].categoryName,
//                         imageUrl: categories[index].imageUrl,
//                       );
//                     })),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 15),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                     height: 210,
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                     enableInfiniteScroll: true,
//                     viewportFraction: 0.8,
//                     autoPlayCurve: Curves.fastOutSlowIn),
//                 items: newsListSlider.map((khabar) {
//                   return Builder(builder: (BuildContext context) {
//                     return Container(
//                         child: Card(
//                             elevation: 3,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Stack(children: [
//                               ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     khabar.imageUrl,
//                                     fit: BoxFit.cover,
//                                     height: double.infinity,
//                                   )),
//                               Positioned(
//                                   left: 0,
//                                   right: 0,
//                                   bottom: 0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         gradient: LinearGradient(
//                                             colors: [
//                                               Colors.black12.withOpacity(0),
//                                               Colors.black
//                                             ],
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter)),
//                                     child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5, vertical: 10),
//                                         child: Text(
//                                           khabar.title,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold),
//                                         )),
//                                   )),
//                             ])));
//                   });
//                 }).toList(),
//               ),
//             ),
//             Container(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "LATEST NEWS ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 28),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: newsList.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           child: Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15)),
//                               elevation: 1.0,
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Image.network(
//                                         newsList[index].imageUrl,
//                                         fit: BoxFit.fitHeight,
//                                         height: 240,
//                                         width: double.infinity,
//                                       )),
//                                   Positioned(
//                                       left: 0,
//                                       right: 0,
//                                       bottom: 0,
//                                       child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                               gradient: LinearGradient(
//                                                   colors: [
//                                                     Colors.black12
//                                                         .withOpacity(0),
//                                                     Colors.black
//                                                   ],
//                                                   begin: Alignment.topCenter,
//                                                   end: Alignment.bottomCenter)),
//                                           padding: EdgeInsets.fromLTRB(
//                                               15, 15, 10, 8),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 newsList[index].title,
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.fade,
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ],
//                                           )))
//                                 ],
//                               )),
//                         );
//                       }),
//                   Container(
//                     //color: Colors.amber,
//                     height: 40,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text("SHOW MORE",
//                           style: TextStyle(color: Colors.black54)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

  
// }
