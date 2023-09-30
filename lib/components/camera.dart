import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Capture Image from Camera",
          style: GoogleFonts.kanit(
              textStyle: TextStyle(color: HexColor('#F5F5DC'))),
        ),
        iconTheme: IconThemeData(color: HexColor('#F5F5DC')),
        backgroundColor: HexColor('#004225'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: controller == null
                    ? Center(child: Text("Loading Camera..."))
                    : !controller!.value.isInitialized
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CameraPreview(controller!)),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(HexColor('#004225'))),
            //image capture button
            onPressed: () async {
              try {
                if (controller != null) {
                  //check if contrller is not null
                  if (controller!.value.isInitialized) {
                    //check if controller is initialized
                    image = await controller!.takePicture(); //capture image
                    setState(() {
                      //update UI
                    });
                  }
                }
              } catch (e) {
                print(e); //show error
              }
            },
            icon: Icon(Icons.camera,color: HexColor('#F5F5DC'),),
            label: Text(
              "Capture",
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: HexColor('#F5F5DC'))),
            ),
          ),
          Container(
            //show captured image
            padding: EdgeInsets.all(30),
            child: image == null
                ? Text("No image captured")
                : Image.file(
                    File(image!.path),
                    height: 300,
                  ),
            //display captured image
          )
        ]),
      ),
    );
  }
}
