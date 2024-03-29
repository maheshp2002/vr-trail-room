import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ArCoreController arCoreController;
  bool use3DModel = true; // Default to use 3D model

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Cloth Matching'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Use PNG Image'),
              Switch(
                value: !use3DModel,
                onChanged: (value) {
                  setState(() {
                    use3DModel = !value;
                  });
                },
              ),
              Text('Use 3D Model'),
            ],
          ),
          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
          ),
        ],
      ),
    );
  }

  _onArCoreViewCreated(arCoreController) {
    this.arCoreController = arCoreController;
    if (use3DModel) {
      _addCube(arCoreController);
    } else {
      _addImage(arCoreController);
    }
  }

  _addCube(ArCoreController arCoreController) {
    final materialColor = MaterialColor(0xFFFF0000, {50: Color(0x00FF0000)});
    final material = ArCoreMaterial(
      color: materialColor,
      metallic: 1.0,
    );

    final cube = ArCoreCube(
      materials: [material],
      size: Vector3(0.5, 0.5, 0.5), // Use Vector3 class for size
    );

    final node = ArCoreNode(
      shape: cube,
      position: Vector3(0, 0, -1),
    );

    arCoreController.addArCoreNode(node);
  }

  _addImage(ArCoreController arCoreController) async {
    // Assuming you have the image as a byte array named 'imageBytes'
    // Load image from assets
    final ByteData byteData =
        await rootBundle.load('assets/images/offer-10.jpg');
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    final image = ArCoreImage(
      bytes: imageBytes,
      width: 100, // Width of the image in pixels
      height: 200, // Height of the image in pixels
    );

    final node = ArCoreNode(
      image: image,
      position: Vector3(0, 0, -1),
    );

    arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
