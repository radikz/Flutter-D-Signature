import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomDialog extends StatelessWidget {
  final ByteData image;

  CustomDialog(this.image);

  @override
  Widget build(BuildContext context) {
    final data = image.buffer.asUint8List();
    return AlertDialog(
      title: Text('Save image?'),
      content: Image.memory(data),
      actions: [
        MaterialButton(
          textColor: Colors.red,
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        MaterialButton(
          textColor: Colors.green,
          onPressed: () {
            storeSignature(context, data).then((msg) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(msg),
                )));
            Navigator.of(context).pop();
          },
          child: Text('SAVE'),
        ),
      ],
    );
  }

  Future<String> storeSignature(BuildContext context, Uint8List data) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'signature_$time';

    final result = await ImageGallerySaver.saveImage(data, name: name, quality: 100);
    print(result);
    final isSuccess = result['isSuccess'];

    if (isSuccess) {
      return 'Successfully save image';
    } else {
      return 'Failed to save the image';
    }
  }
}
