import 'package:flutter/material.dart';
import 'package:newsapp/constants/values.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/pages/viewnews.dart';

class TiledNewsView extends StatelessWidget {
  TiledNewsView({Key? key}) : super(key: key);
  final List<News> news = StaticValues().news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(news.length, (index) {
        News newsItem = news[index];
        int newsDescriptionLength = newsItem.descrption.split(' ').length;
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsViewPage(newsPost: newsItem)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    newsItem.image,
                    width: 87,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Text(
                        getTruncatedTitle(newsItem.title, 60),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} read",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          Text(
                            newsItem.time,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}
