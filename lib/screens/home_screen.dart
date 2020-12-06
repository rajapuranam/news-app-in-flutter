import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/helper/category_data.dart';
import 'package:news_app/helper/news_data.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/screens/searchnews_screen.dart';
import 'package:news_app/widgets/category_tile.dart';
import 'package:news_app/widgets/headline_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories;
  List<NewsArticle> newsList = [];
  bool loading = true;
  TextEditingController searchController = new TextEditingController();

  PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
    categories = getCategoriesList();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    newsList = news.newsList;
    setState(() {
      loading = false;
    });
  }

  animateItemBuilder(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            // width: Curves.easeOut.transform(value) * 250,
            child: child,
          ),
        );
      },
      child: Container(
        height: 300,
        child: CategoryTile(categoryName: categories[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily News",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'NunitoBold',
                    color: Theme.of(context).accentColor,
                    letterSpacing: 1.4,
                  ),
                ),
                Text(
                  "Explore today's world news",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "search",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchNewsResults(
                                search: searchController.text.toLowerCase(),
                              ),
                            ),
                          );
                          // searchController.text = '';
                        },
                        child: Icon(Icons.search),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 300,
                  child: PageView.builder(
                    itemCount: categories.length,
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) => animateItemBuilder(index),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  child: Text(
                    'Top Headlines',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NunitoBold',
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 2.5,
                    endIndent: MediaQuery.of(context).size.width - 80),
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
