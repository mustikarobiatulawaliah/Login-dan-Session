import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/editnews_bloc.dart';

class EditForm extends StatefulWidget {
  final String id, title, url, desc, date;
  const EditForm(
      {required this.id,
      required this.title,
      this.url = "",
      required this.desc,
      required this.date});
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    contentController.text = widget.desc;
    dateController.text = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add News')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(2000), //DateTime.now() - not to allow to
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dateController.text =
                          formattedDate; // set output date to TextField
                    });
                  }
                },
              ),
              _pickedImage == null
                  ? Image.network(
                      widget.url, // Replace with the actual image URL
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              _pickedImage != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.contain,
                      ))
                  : SizedBox.shrink(),
              ElevatedButton(
                onPressed: () async {
                  // Fungsi pemilihan file dari perangkat lokal dan file
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg'],
                  );

                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _pickedImage = File(result.files.single.path!);
                    });
                  }
                },
                child: Text('Pick Image (.jpg)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if ((_pickedImage == null && widget.url == "") ||
                      titleController.text == "" ||
                      contentController.text == "" ||
                      dateController.text == "") {
                    log("Masuk Kondisi If Edit Klik Tombol");
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('No Image'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Silahkan Lengkapi Data'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  } else {
                    log("Masuk Kondisi Else Edit Klik Tombol");
                    final id = widget.id;
                    final title = titleController.text;
                    final content = contentController.text;
                    final date = dateController.text;
                    final image = _pickedImage;

                    context.read<EditnewsBloc>().add(ClickEdit(
                          id: id,
                          title: title,
                          content: content,
                          date: date,
                          image: image,
                        ));
                  }
                },
                child: Text('Edit News'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
