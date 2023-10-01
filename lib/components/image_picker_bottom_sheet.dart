import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(ImageSource source) onImageSourceSelected;

  ImagePickerBottomSheet({required this.onImageSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a Picture'),
            onTap: () {
              Navigator.of(context).pop();
              onImageSourceSelected(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Pick from Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              onImageSourceSelected(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
