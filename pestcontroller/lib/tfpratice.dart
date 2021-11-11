import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pestcontroller/components/rounded_button.dart';
import 'package:pestcontroller/imageresize.dart';
import 'package:pestcontroller/viewDetails.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:core';
import 'package:firebase_database/firebase_database.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class TfliteHome extends StatefulWidget {
  @override
  _TfliteHomeState createState() => new _TfliteHomeState();
}

//@dart=2.9
class _TfliteHomeState extends State<TfliteHome> {
  String name1 = ' Wait';
  String _model = ssd;
  File? _image;
  File? file;
  Uint8List _bytes = Uint8List(0);

  double _imageWidth = 0;
  double _imageHeight = 0;
  bool _busy = false;
  bool flag = false;
  List _recognitions = [];

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        res = (await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        ))!;
      } else {
        res = (await Tflite.loadModel(
          model: "assets/damn.tflite",
          labels: "assets/label3.txt",
        ))!;
      }
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  Future<void> fetchDatabase() async {
    final db = FirebaseDatabase.instance.reference().child('esp32-cam');
    db.once().then((DataSnapshot snapshot) {
      /* setState(() {
        name = snapshot.value['-MgHJNm3MGf9ddhXtIjo']['photo'].toString();
        final UriData? data = Uri.parse(name).data;
        print(data!.isBase64);
        _bytes = data.contentAsBytes();
        _busy = false;
        //name = name.substring(23);
       // _bytes = base64Decode(name);
        print(_bytes);
     //   print("Crossed..");
        //file.writeAsBytesSync(_bytes);'
     //   file = _createFileFromString(name) as File?;
        //file = File.fromRawPath(_bytes);
    //    print("Crossed");
       // print(file!.path);
     //   if (file!=null){
      //  print("check1");
     //       predictImage(file!);
     //   }
      });*/
    });
    setState(() {
      _busy = true;
    });
    //Future<String> file = _createFileFromString(name);
  }

  Future<File> _createFileFromString(String encodedStr) async {
    Uint8List bytes = base64.decode(encodedStr);
    print(bytes);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    setState(() {
      print("file $file");
    });
    return File(file.path);
  }

  selectFromImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(File(image.path));
  }

  predictImage(File image) async {
    //ImageResize();
    print("Crossed............");
    if (image == null) return;

    if (_model == yolo) {
      await yolov2Tiny(image);
    } else {
      await ssdMobileNet(image);
    }
    new FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            // _imageHeight = 500;
            //_imageWidth = 500;
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            print(_imageWidth);
            print(_imageHeight);
          });
        })));
    print("Crossed4");
    setState(() {
      _image = image;
      _busy = false;
      flag = true;
      print("Crossed5");
    });
  }

  Future yolov2Tiny(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions!;
    });
  }

  Future ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "SSDMobileNet",
        imageMean: 124,
        imageStd: 124,
        threshold: 0.4,
        numResultsPerClass: 12,
        asynch: true);

    setState(() {
      _recognitions = recognitions!;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    Color blue = Colors.red;

    return _recognitions.map((re) {
      setState(() {
        name1 = re["detectedClass"];
      });
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: blue,
            width: 3,
          )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    String name = '';
    Size size = MediaQuery.of(context).size;
    print('size$size');
    print(name1.substring(0,1));
    int k = 0;
    print(k);
    print(k.runtimeType);
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        child: _image == null
            ? Text("No Image Selected")
            : Image.file(
                _image!,
                fit: BoxFit.cover,
              )

        /*Container(
          height: 500,
          width: 500,
          child: Image.file(_image!,fit: BoxFit.cover,)),*/
        ));

    stackChildren.add(Positioned(
      bottom: 60.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Container()
          : Column(
              children: [
                Text(
                  name1.substring(2).toString() == "bph"
                      ? "Brown Plant Hopper"
                      : name1.substring(2).toString() == "lf"
                          ? "leaf folder"
                          : name1.substring(2).toString() == "glh"
                              ? "Green leaf hopper"
                              : "Pest detected successfully!",
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 20,
                  ),
                ),
                RoundedButton(
                  text: "View Details",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewDetails(count, name1.substring(1), 1,name1.substring(0,1))));
                  },
                ),
              ],
            ),
    ));
    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    setState(() {
      count = stackChildren.length - 2;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("TFLite Demo"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.image),
        tooltip: "Pick Image from gallery",
        onPressed: () {
          selectFromImagePicker();
          // setState(() {
          //  fetchDatabase();
          //   flag =true;
          // });
        },
      ),
      body: Stack(
        children: stackChildren,
      ),
    );
  }
}
