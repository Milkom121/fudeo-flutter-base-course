import 'package:flutter/material.dart';

import 'package:ansa/pages/article_detail.dart';
import 'package:ansa/models/article.dart';
import 'package:ansa/providers/api.dart';

class LastHourPage extends StatelessWidget {
  Widget buildHeader() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Notizie dell'ultima ora",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "Top 10 storie qui per te",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black45),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Column(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "7 Lug",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }

  Widget buildHeadline(BuildContext context, Article article) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage),
                   fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "NOTIZIE DI PUNTA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              article.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              article.content,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ));
  }

  Widget buildArticle(BuildContext context, Article article) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article),
              ));
        },
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  article.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            )),
            SizedBox(
              width: 16,
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: topHeadlines(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.done:
            List<Article> articles = snapshot.data;

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: 1 + articles.length,
              itemBuilder: (context, index) {
                if (index == 0)
                  return buildHeader();
                else if (index == 1)
                  return Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: buildHeadline(context, articles[index-1]));
                else
                  return Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: buildArticle(context, articles[index-1]));
              },
            );

          default:
            return Center(
              child: Text("ERRORE"),
            );
        }
      },
    );
  }
}
