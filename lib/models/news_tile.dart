// import 'dart:convert';
// import 'package:http/http.dart' as http;
 import 'package:flutter/material.dart';
// import 'package:news_app/models/news.dart';























// class NewsTile extends StatefulWidget {
//   const NewsTile({Key key}) : super(key: key);

//   @override
//   State<NewsTile> createState() => _NewsTileState();
// }

// class _NewsTileState extends State<NewsTile> {
//  final String apiKey = 'apiKey=8059b98d617342a3885a4a44f35fea34';
//   final String baseUrl = 'https://newsapi.org/v2';
//  List<News> newsList = [];
//  bool isLoading = true;
//  int page = 1;


//  Future getNewsByQuery(String query) async {
//     String url = '$baseUrl/everything?q=$query&$apiKey';
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
 

//  loadMore() async {
//     setState(() {
//       page = page + 1;
//     });
//     String url = '$baseUrl/everything?q=china&$apiKey&page=' + page.toString();
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

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: newsList.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 child: Card(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Container(
//                               alignment: Alignment.center,
//                               //color: Colors.amber,
//                               width: 210,
//                               height: 120,
//                               child: Text(
//                                 newsList[index].title,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 4,
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             //color: Colors.amber,
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.newspaper,
//                                   color: Colors.red,
//                                   size: 19,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   newsList[index].sourceName != null
//                                       ? newsList[index].sourceName
//                                       : 'Anonymus',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Container(
//                           height: 150,
//                           width: 165,
//                           //color: Colors.amber,
//                           child: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                       //alignment: Alignment.center,
//                                       height: 110,
//                                       width: 138,
//                                       child: Image.network(
//                                         newsList[index].imageUrl != null
//                                             ? newsList[index].imageUrl
//                                             : Center(child: Text('...')),
//                                         fit: BoxFit.fill,
//                                       )),
//                                   Positioned(
//                                     right: 0,
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         color: Colors.white,
//                                         icon: Icon(Icons.bookmark_add)),
//                                   )
//                                 ],
//                               )))
//                     ],
//                   ),
//                 ),
//               );
//             }),
//         Container(
//           //color: Colors.amber,
//           height: 40,
//           child: ElevatedButton(
//             onPressed: loadMore,
//             child: Text("SHOW MORE", style: TextStyle(color: Colors.black54)),
//           ),
//         ),
//         SizedBox(
//           height: 50,
//         )
//       ],
//     );
//   }
// }
