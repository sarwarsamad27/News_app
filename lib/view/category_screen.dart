import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoppinghere/view/news_detail_screen.dart';
import 'package:shoppinghere/view/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';
import 'home_screen.dart';

class categoryScreen extends StatefulWidget {
  const categoryScreen({super.key});

  @override
  State<categoryScreen> createState() => _categoryScreenState();
}

class _categoryScreenState extends State<categoryScreen> {
  NewViewModel newViewModel = NewViewModel();

  final format = DateFormat('MMMM, dd, yyyy ');

  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: categoryName == categoriesList[index]
                                  ? Colors.blue
                                  : Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                  future: newViewModel.fetchCategories(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailScreen(
                                  source: snapshot.data!.articles![index].source.toString(),
                                  newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                  newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                  newsTitle: snapshot.data!.articles![index].title.toString(),
                                  author: snapshot.data!.articles![index].author.toString(),
                                  description: snapshot.data!.articles![index].description.toString(),
                                  content: snapshot.data!.articles![index].content.toString(),
                                )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .3,
                                        placeholder: (context, url) => Container(
                                          child: Spinket2,
                                        ),
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.no_accounts_outlined,
                                          size: 90,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * .01,),
                                    Expanded(
                                      child: Container(
                                        height: height * .18,
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index].source!.name
                                                      .toString(),
                                                  maxLines: 3,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12  ,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500),
                                                ),

                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
