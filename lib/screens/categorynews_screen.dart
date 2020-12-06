import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/helper/news_data.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/widgets/headline_tile.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<NewsArticle> newsList = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getCategoryNews(category: widget.category);
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
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: innerBoxIsScrolled
                        ? Theme.of(context).accentColor
                        : Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 1.0,
                expandedHeight: MediaQuery.of(context).size.height - 550,
                floating: true,
                pinned: true,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    '${widget.category[0].toUpperCase()}${widget.category.substring(1)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NunitoBold',
                      color: innerBoxIsScrolled
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  background: Image.asset(
                    'assets/images/' + widget.category.toLowerCase() + '.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
      ),
    );
  }
}
