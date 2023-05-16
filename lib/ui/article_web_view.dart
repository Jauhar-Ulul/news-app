import 'package:flutter/material.dart';
import 'package:news_app/article.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widget/custom_scaffold.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const ArticleWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: WebView(
      initialUrl: url,
    ));
  }
}
