import 'dart:developer';

import 'package:examplebloc/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'editnews.dart';

class DetailViewLoad extends StatefulWidget {
  final String id, title, url, desc, date;
  const DetailViewLoad(
      {required this.id,
      required this.title,
      required this.url,
      required this.desc,
      required this.date});
  @override
  State<DetailViewLoad> createState() => _DetailViewLoadState();
}

class _DetailViewLoadState extends State<DetailViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showOptionsDialog(context).then((res) {
                log("RES $res");
                if (res == 'delete') {
                  log("Pilih Hapus $res");
                  context
                      .read<DetailBloc>()
                      .add(DeleteNews(id: widget.id, title: widget.title));
                } else if (res == 'edit') {
                  log("Pilih Edit $res");
                  // logika edit disini
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNews(
                            id: widget.id,
                            title: widget.title,
                            url: widget.url,
                            desc: widget.desc,
                            date: widget.date)),
                  ).then((value) {
                    if (value == 'reload') {
                      context
                          .read<DetailBloc>()
                          .add(LoadNewsEvent(newsId: widget.id));
                    }
                  });
                }
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Image.network(
                widget.url, // Replace with the actual image URL
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(widget.desc, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the alert dialog with "Edit" and "Delete" options
  Future showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kelola Data'),
          content: const Text('Apa yang ingin Anda lakukan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('edit');
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('delete');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
