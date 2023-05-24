import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/article.dart';
import '../data/api/api_service.dart';
import '../widget/platform_widget.dart';
import '../widget/card_article.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<NewsListPage> createState() => _NewsListPage();
}

class _NewsListPage extends State<NewsListPage> {
  Future<ArticleResult>? _article;
  String category = '';
  String search = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines(category);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Search News"),
                        onChanged: (val) {
                          search = val;
                        },
                        onSubmitted: (value) async {
                          print(search);
                          setState(() {
                            _article = ApiService().searchNews(search);
                          });

                          searchController.clear();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      onPressed: () async {
                        print(search);

                        searchController.clear();
                      },
                      icon: const Icon(
                        Icons.search_sharp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildList(context),
          ],
        ),
      ),
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
        print(category);
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            return Text('News not found');
          }
        }
      },
    );
  }

  Widget _buildDrawer() {
    return SizedBox(
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.local_fire_department),
              title: Text('Headlines'),
              onTap: () {
                category = '';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Business'),
              onTap: () {
                category = 'business';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text('Entertainment'),
              onTap: () {
                category = 'entertainment';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('General'),
              onTap: () {
                category = 'general';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text('Health'),
              onTap: () {
                category = 'health';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.biotech),
              title: Text('science'),
              onTap: () {
                category = 'science';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.sports_basketball_rounded),
              title: Text('Sports'),
              onTap: () {
                category = 'sports';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
            ListTile(
              leading: Icon(Icons.desktop_mac),
              title: Text('Technology'),
              onTap: () {
                category = 'technology';
                setState(() {
                  _article = ApiService().topHeadlines(category);
                });
                print(category);
              },
            ),
          ],
        ),
      ),
    );
  }
}
