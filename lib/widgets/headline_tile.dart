import 'package:flutter/material.dart';
import 'package:news_app/screens/webview_screen.dart';

class HeadlineTile extends StatelessWidget {
  final String imgUrl, title, sourceName, posturl;
  final int indexVal;

  HeadlineTile({
    @required this.imgUrl,
    @required this.title,
    @required this.sourceName,
    @required this.posturl,
    @required this.indexVal,
  });

  final List bgList = [
    Colors.green.withOpacity(0.2),
    Colors.red.withOpacity(0.2),
    Colors.yellow.withOpacity(0.2),
    Colors.blue.withOpacity(0.2),
    Colors.deepPurple.withOpacity(0.2),
  ];

  final List fgList = [
    Colors.green[800],
    Colors.red[800],
    Colors.yellow[800],
    Colors.blue[800],
    Colors.deepPurple[800],
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              postUrl: posturl,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgList[indexVal % 5],
                        ),
                        child: Text(
                          sourceName,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NunitoBold',
                            fontWeight: FontWeight.w700,
                            color: fgList[indexVal % 5],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        title,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NunitoSemiBold',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imgUrl,
                      height: 180,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 50,
            thickness: 1,
            endIndent: 25,
            indent: 25,
          ),
        ],
      ),
    );
  }
}
