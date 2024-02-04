import 'package:examplebloc/layout/detailnews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/managenews_bloc.dart';

class ListNews extends StatelessWidget {
  final List news;
  String searchText; // Assuming your news data is a list of maps

  ListNews({super.key, required this.news, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    TextEditingController _search = TextEditingController(text: searchText);
    return Scaffold(
      appBar: AppBar(title: Text("List News")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          TextField(
            controller: _search,
            decoration: InputDecoration(labelText: 'Cari Berita'),
          ),
          ElevatedButton(
            onPressed: () {
              final search = _search.text;

              // Dispatch login event to Bloc
              context
                  .read<ManagenewsBloc>()
                  .add(LoadListNewsEvent(keyword: search));
            },
            child: Text('Cari'),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: news.length,
              itemBuilder: (context, index) {
                final Map newsItem = news[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      newsItem['img'], // Replace with
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                    title: Text(newsItem['title']),
                    subtitle: Text(newsItem['date']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNews(
                                  newsId: newsItem['id'],
                                )),
                      ).then((value) {
                        // log("ret $value");
                        // if (value == 'reload') {
                        final search = _search.text;

                        // Dispatch login event to Bloc
                        context
                            .read<ManagenewsBloc>()
                            .add(LoadListNewsEvent(keyword: search));
                        // }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
