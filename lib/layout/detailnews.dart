import 'package:examplebloc/bloc/detail_bloc.dart';
import 'package:examplebloc/layout/detailload.dart';
import 'package:examplebloc/layout/error_message.dart';
import 'package:examplebloc/layout/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailNews extends StatefulWidget {
  final int newsId;
  const DetailNews({super.key, required this.newsId});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context
          .read<DetailBloc>()
          .add(LoadNewsEvent(newsId: widget.newsId.toString()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          return LoadingIndicator();
        } else if (state is LoadFailed) {
          return ErrorMessage(message: state.msg);
        } else if (state is NewsDeleted) {
          return Scaffold(
            appBar: (AppBar(
              title: const Text("Hapus Sukses"),
            )),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Center(
                      child: Text("Berita '${state.title}' berhasil dihapus")),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop('reload');
                      },
                      child: const Text('Kembali Ke List Berita'),
                    ),
                  ),
                ],
              )),
            ),
          );
        } else if (state is DetailLoaded) {
          return DetailViewLoad(
              id: state.news['id'].toString(),
              title: state.news['title'],
              url: state.news['img'],
              desc: state.news['desc'],
              date: state.news['date']);
        } else {
          return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("UnKnown Error"))));
        }
      },
    );
  }
}
