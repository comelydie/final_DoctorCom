import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../../constants.dart';

class CameraTake extends StatefulWidget {
  const CameraTake({
    Key key,
  }) : super(key: key);

  @override
  _CameraTakeState createState() => _CameraTakeState();
}

class _CameraTakeState extends State<CameraTake> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(_image);
  }

  takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loading
              ? Container(
                  height: 300,
                  width: 300,
                )
              : Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null ? Container() : Image.file(_image),
                      SizedBox(
                        height: 20,
                      ),
                      _image == null
                          ? Container()
                          : _outputs != null
                              ? Text(
                                  _outputs[0]["label"],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )
                              : Container(child: Text(""))
                    ],
                  ),
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new FloatingActionButton(
                heroTag: "btn1",
                tooltip: 'Pick Image',
                onPressed: pickImage,
                child: Icon(
                  Icons.photo_size_select_actual_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
              ),
              new FloatingActionButton(
                heroTag: "btn2",
                tooltip: 'Take a photo ',
                onPressed: takePhoto,
                child: Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
