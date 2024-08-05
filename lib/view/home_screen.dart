import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoppinghere/model/News_channel_headlines_model.dart';
import 'package:shoppinghere/view/category_screen.dart';
import 'package:shoppinghere/view/news_detail_screen.dart';
import 'package:shoppinghere/view/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  googleNewsIt,
  alJazeera,
  googleNews,
  cbcNews,
  abc
}

class _homeScreenState extends State<homeScreen> {
  NewViewModel newViewModel = NewViewModel();

  FilterList? selectMenu;

  final format = DateFormat('MMMM, dd, yyyy ');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const categoryScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            scale: 20,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterList.googleNewsIt.name == item.name) {
                  name = 'google-news-it';
                }
                if (FilterList.alJazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (FilterList.googleNews.name == item.name) {
                  name = 'google-news';
                }
                if (FilterList.cbcNews.name == item.name) {
                  name = 'cbc-news';
                }
                if (FilterList.abc.name == item.name) {
                  name = 'abc-news';
                }

                setState(() {
                  selectMenu = item;
                });
                // setState(() {
                //
                // });
              },
              initialValue: selectMenu,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text('BBC News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text('ARY News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.googleNewsIt,
                      child: Text('google News Italy'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.alJazeera,
                      child: Text('Al-Jazeera News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.googleNews,
                      child: Text('Google News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cbcNews,
                      child: Text('CBC News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.abc,
                      child: Text('ABC'),
                    ),
                  ])
        ],
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<news_channel_headlines_model>(
                future: newViewModel.fetchNewsChannel(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                            source: snapshot
                                                .data!.articles![index].source
                                                .toString(),
                                            newsDate: snapshot.data!
                                                .articles![index].publishedAt
                                                .toString(),
                                            newsImage: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            newsTitle: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            description: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            content: snapshot
                                                .data!.articles![index].content
                                                .toString(),
                                          )));
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * .6,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * .02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: Spinket2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 40),
                                          child: Icon(
                                            Icons.no_accounts_sharp,
                                            color: Colors.red,
                                            size: 200,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: height * .22,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * .7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: width * .7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
                future: newViewModel.fetchCategories('general'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return

                            InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                            source: snapshot
                                                .data!.articles![index].source
                                                .toString(),
                                            newsDate: snapshot.data!
                                                .articles![index].publishedAt
                                                .toString(),
                                            newsImage: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            newsTitle: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            description: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            content: snapshot
                                                .data!.articles![index].content
                                                .toString(),
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
                                      errorWidget: (context, url, error) => const Icon(
                                        Icons.no_accounts_outlined,
                                        size: 90,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),

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
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
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
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
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
    );
  }
}

const Spinket2 = SpinKitCircle(
  color: Colors.blue,
  size: 50,
);
