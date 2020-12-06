import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/helper/news_data.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/widgets/headline_tile.dart';

// ignore: must_be_immutable
class SearchNewsResults extends StatefulWidget {
  String search;
  SearchNewsResults({this.search});
  @override
  _SearchNewsResultsState createState() => _SearchNewsResultsState();
}

class _SearchNewsResultsState extends State<SearchNewsResults> {
  List<NewsArticle> newsList = [NewsArticle()];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getSearchNews(search: widget.search);
    newsList = news.newsList;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: newsList.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/noresults.jpg',
                      width: 250,
                      height: 250,
                    ),
                    Text(
                      'No results found for',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NunitoSemiBold',
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${widget.search[0].toUpperCase()}${widget.search.substring(1)}',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'NunitoBold',
                        color: Theme.of(context).accentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Showing results for',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NunitoBold',
                          color: Colors.black38,
                        ),
                      ),
                      Container(
                        child: Text(
                          '${widget.search[0].toUpperCase()}${widget.search.substring(1)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'NunitoBold',
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 2.5,
                        endIndent: MediaQuery.of(context).size.width - 80,
                      ),
                      SizedBox(height: 10),
                      loading
                          ? SpinKitDoubleBounce(
                              color: Theme.of(context).accentColor,
                              size: 50.0,
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              child: ListView.builder(
                                itemCount: newsList.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return HeadlineTile(
                                imgUrl: newsList[index].imgUrl ?? "No Image",
                                title: newsList[index].title ?? "No Title",
                                posturl: newsList[index].postUrl ?? "No Post",
                                sourceName: newsList[index].sourceName ?? "No Source",
                                indexVal: index,
                              );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
