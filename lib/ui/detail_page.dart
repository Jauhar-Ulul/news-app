import 'package:flutter/material.dart';
import 'package:news_app/article.dart';
import 'article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage!,
              child: Image.network(article.urlToImage!),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Author: ${article.author}',
                      style: Theme.of(context).textTheme.caption),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(article.content ?? "",
                      style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ArticleWebView.routeName,
                            arguments: article.url);
                      },
                      child: Text('Read More'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
