import 'package:examplebloc/layout/editform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/editnews_bloc.dart';
import 'loading.dart';
import 'error_message.dart';

class EditNews extends StatefulWidget {
  final String id, title, url, desc, date;
  const EditNews(
      {required this.id,
      required this.title,
      required this.url,
      required this.desc,
      required this.date});

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<EditnewsBloc>().add(SetInit());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditnewsBloc, EditnewsState>(
      builder: (context, state) {
        if (state is EditnewsInitial) {
          return EditForm(
              id: widget.id,
              title: widget.title,
              url: widget.url,
              desc: widget.desc,
              date: widget.date);
        } else if (state is LoadingEdit) {
          return LoadingIndicator();
        } else if (state is SuccessEdit) {
          return Scaffold(
            appBar: AppBar(title: const Text("Edit News")),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop('reload');
                        },
                        child: const Text("Lihat Berita"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ErrorEdit) {
          return ErrorMessage(message: "Gagal Edit");
        } else {
          return Container();
        }
      },
    );
  }
}
