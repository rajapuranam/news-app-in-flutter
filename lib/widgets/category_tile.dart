import 'package:flutter/material.dart';
import 'package:news_app/screens/categorynews_screen.dart';

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
  final String categoryName;
  String imageUrl;

  CategoryTile({@required this.categoryName}) {
    imageUrl = 'assets/images/' + categoryName.toLowerCase() + '.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: categoryName.toLowerCase(),
          )
        ));
        
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                imageUrl,
                height: 300,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black26,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  categoryName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NunitoSemiBold',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
