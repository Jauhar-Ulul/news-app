import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/article.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/api/api_service.dart';
import '../widget/custom_scaffold.dart';
import '../widget/platform_widget.dart';
import '../widget/card_article.dart';
import 'detail_page.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<NewsListPage> createState() => _NewsListPage();
}

class _NewsListPage extends State<NewsListPage> {
  Future<ArticleResult>? _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _article,
      builder: (context, AsyncSnapshot<ArticleResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.articles.length,
              itemBuilder: (context, index) {
                var article = snapshot.data?.articles[index];
                return CardArticle(article: article!);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Text('');
          }
        }
      },
    );
  }
}
