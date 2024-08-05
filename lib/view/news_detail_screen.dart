import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  NewsDetailScreen({
    super.key,
    required this.source,
    required this.newsDate,
    required this.newsImage,
    required this.newsTitle,
    required this.author,
    required this.description,
    required this.content,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  final format = DateFormat('MMMM, dd, yyyy ');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage ,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url , error)=>
                  const Padding(
                    padding:
                    EdgeInsets.only(bottom: 40),
                    child: Center(
                      child: Icon(
                        Icons.no_accounts_sharp,
                        color: Colors.red,
                        size: 200,
                      ),
                    ),
                  ),
                )),
            height: height * .45,
          ),

          Expanded(
            child: Container(
              height: height * .6,
              margin: EdgeInsets.only(top: height * .4),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: ListView(
                children: [
                  Text(
                    widget.newsTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.source,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ),
                      Text(
                        format.format(dateTime),
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ],
              ),
              ),
          )
        ],
      ),
    );
  }
}
