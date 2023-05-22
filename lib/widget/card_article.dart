import 'package:flutter/material.dart';
import 'package:news_app/article.dart';
import 'package:news_app/style.dart';
import 'package:news_app/ui/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          width: 100,
          child: CachedNetworkImage(
            imageUrl: article.urlToImage!,
            placeholder: (context, url) => Center(
              child: new CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) => new Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
        //     Hero(
        //       tag: article.urlToImage!,
        //       child: Container(
        //           width: 100,
        //           child: Image.network(article.urlToImage!,
        //               width: 100, fit: BoxFit.fill)),
        //     ),
        title: Text(article.title!),
        subtitle: Text(article.author!),
        onTap: () => Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article),
      ),
    );
  }
}
