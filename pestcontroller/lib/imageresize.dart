
import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as I;
import 'package:path/path.dart' as path;

class ImageResize extends StatefulWidget {
  const ImageResize({Key? key}) : super(key: key);

  @override
  _ImageResizeState createState() => _ImageResizeState();
}
int flag=0;
String URL='';
String name ='';
I.Image? _img ;
class _ImageResizeState extends State<ImageResize> {
  var url;
  int error=0;
  File? _image;
  Uint8List _bytes = Uint8List(0);
  File? file;
  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
    http.Response response = await http.get(url);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future<void> fetchDatabase() async{
    final db = FirebaseDatabase.instance.reference().child('esp32-cam');
    db.once().then((DataSnapshot snapshot) {
      setState(() async {
        name = snapshot.value['sample']['test'].toString();
        //final UriData? data = Uri.parse(name).data;
       // print(data!.isBase64);
       // _bytes = data.contentAsBytes();
        //print(data);
        name = name.substring(23);
       // name = name.replaceAll('%', '/');
       // name = name.replaceAll("\n", '');
      /*  print(name);
        if (name.length % 4 > 0) {
          name += '=' * (4 - name.length % 4);// as suggested by Albert221
        }
      //  if(isBase64(name))
       //   {
        //    _bytes = Base64Decoder().convert(name);
         // }*/
        _bytes = base64Decode(name);
        //_img = I.decodeImage(_bytes);
       // _img = I.encodeJpg(_img!) as I.Image?;
       // new Image.memory(_img!.getBytes());
        print(_bytes);
        file = File.fromRawPath(_bytes);
        var ext = path.extension(file!.path);
        print("Crosedasdscae");
        print("file $ext");
       // file!.writeAsBytesSync(_bytes);
        //file = _createFileFromString(name);
      });
    });
  }


  Future<File> _createFileFromString(String encodedStr) async {
    Uint8List bytes = base64.decode(encodedStr);
    print(bytes);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");

    await file.writeAsBytes(bytes);
    setState(() {
      Image.file(file);
      print("file $file");
    });
    return file;
  }

  Future<void> fetchURL()async {
    try{
      url = Uri.parse("https://firebasestorage.googleapis.com/v0/b/pest-detection-67f76.appspot.com/o/imageData.jpeg?alt=media&token=a93d82cf-c163-4d0b-8b12-b3ed4992a6d6");
      var response=await http.get(url);
      error= jsonDecode(response.body)['error']['code'];
      print(error);
    }
    catch(e){}
    if(error==404){
      print('1');
      setState(() {
        URL="https://www.programmingr.com/wp-content/uploads/2020/07/error-message.png";
      });

    }
    else{
      setState(() {
        URL="https://firebasestorage.googleapis.com/v0/b/pest-detection-67f76.appspot.com/o/imageData.jpeg?alt=media&token=a93d82cf-c163-4d0b-8b12-b3ed4992a6d6";
      });
    }
    _image = urlToFile(URL) as File;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Row(
              children:[
                Text(
                  'Pest Detection',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children:[
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    fetchDatabase();
                    flag=1;
                  });
                },
                child: null,
              ),
              Container(
                child: flag==1 ?Image.memory(
                  _bytes, height: 150.0, fit: BoxFit.cover,) : Container(),
              ),

        ],
      ),

      ),
    );
  }
}
