import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/functions.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/users/login.dart';

class AddUserAvatar extends StatefulWidget {
  const AddUserAvatar({super.key, required this.id});
  final int id ;

  @override
  State<AddUserAvatar> createState() => _AddUserAvatarState();
}

class _AddUserAvatarState extends State<AddUserAvatar> {
  Uint8List? fileBytes;
  String fileName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Avatar'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              fileBytes == null
                  ? Container(
                      height: 200,
                      width: 200,
                      color: Colors.grey,
                      child: Center(
                        child: Text('No Image'),
                      ),
                    )
                  : Image.memory(
                      fileBytes!,
                      height: 350,
                      width: 200,
                    ),
              IconButton(
                  icon: Icon(Icons.upload_file_outlined),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                        setState(() {
                          fileBytes = result.files.first.bytes;
                          fileName = result.files.first.name;
                        });
                    }
                  }),
              ElevatedButton(
                onPressed: () async {
                  if (fileBytes != null) {
                    http.StreamedResponse response = await uploadAvatar(fileBytes, fileName, widget.id);
                    if (response.statusCode == 200) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  }
                  // Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Book',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
