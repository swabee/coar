import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  final faceDetector = GoogleMlKit.vision.faceDetector();
  bool faceDetected = false;
  List<Face> detectedFaces = [];
  ui.Image? necklaceImage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    loadNecklaceImage();
  }

  Future<void> initializeCamera() async {
    var frontCamera = cameras
        ?.where((c) => c.lensDirection == CameraLensDirection.front)
        .first;
    controller = CameraController(frontCamera!, ResolutionPreset.high);
    await controller.initialize();
    if (!mounted) return;

    setState(() {});
    startFaceDetection();
  }

  Future<void> loadNecklaceImage() async {
    final byteData = await rootBundle.load('asset/thali_nobg.png');
    final bytes = byteData.buffer.asUint8List();
    final img.Image? decodedImage = img.decodeImage(bytes);
    if (decodedImage != null) {
      final codec = await ui.instantiateImageCodec(bytes);
      final frameInfo = await codec.getNextFrame();
      necklaceImage = frameInfo.image;
      setState(() {});
    }
  }

  void startFaceDetection() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      if (!controller.value.isStreamingImages) {
        await controller.startImageStream((CameraImage image) async {
          if (faceDetected) return; // Skip if a face is already detected

          try {
            // Convert CameraImage to InputImage
            final inputImage = getInputImageFromCameraImage(image, 90);

            // Detect faces in the frame
            final List<Face> faces =
                await faceDetector.processImage(inputImage);

            if (faces.isNotEmpty) {
              setState(() {
                faceDetected = true;
                detectedFaces = faces;
              });
            }
          } catch (e) {
            print('Error detecting faces: $e');
          }
        });
      }
    });
  }

// Helper function to convert CameraImage to InputImage
  InputImage getInputImageFromCameraImage(
      CameraImage image, int sensorOrientation) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final InputImageRotation imageRotation =
        _rotationIntToImageRotation(sensorOrientation);

    final InputImageFormat inputImageFormat = InputImageFormat.nv21;

    // final planeData = image.planes.map(
    //   (Plane plane) {
    //     return InputImagePlaneMetadata(
    //       bytesPerRow: plane.bytesPerRow,
    //       height: plane.height,
    //       width: plane.width,
    //     );
    //   },
    // ).toList();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        bytesPerRow: 1800,
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        // planeData: planeData,
      ),
    );
  }

// Convert sensor orientation to InputImageRotation
  InputImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      case 0:
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized || necklaceImage == null) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon:Icon(CupertinoIcons.back)),
        title: const Text(''),
      ),
      body: Stack(
        children: <Widget>[
          CameraPreview(controller),
          faceDetected
              ? Positioned.fill(
                  child: CustomPaint(
                    painter: FaceOverlayPainter(
                      faces: detectedFaces,
                      image: necklaceImage!,
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DottedBorder(
                        borderType: BorderType.Oval,
                        color: const ui.Color.fromARGB(255, 0, 255, 225),
                        strokeWidth: 3.sp,
                        dashPattern: const [6, 3],
                        padding: const EdgeInsets.all(6),
                        child: ClipOval(
                          child: SizedBox(
                            height: 380.h,
                            width: 240.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Please align your face within the oval.',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    faceDetector.close();
    _timer?.cancel();
    super.dispose();
  }
}

class FaceOverlayPainter extends CustomPainter {
  final List<Face> faces;
  final ui.Image image;

  FaceOverlayPainter({required this.faces, required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    if (faces.isEmpty) return;

    final Paint paint = Paint();
    for (Face face in faces) {
      // Get the width of the bounding box
      // final double faceWidth = face.boundingBox.width;

      // Calculate the scale factor based on the face width
      // Here, you can adjust the divisor to control the sensitivity of the scaling
      // final double scaleFactor = faceWidth / 90; // Adjust this value to fit your needs

      // Calculate the center of the face
      final Offset faceCenter = face.boundingBox.center;

      // Scale factors to adjust the size of the necklace image
      final double scaleX = .6; // Scale necklace based on face size
      final double scaleY = .6; // Scale necklace based on face size

      // Calculate the scaled position based on the center of the face
      final Offset scaledPosition = Offset(
        faceCenter.dx*.55,
        faceCenter.dy *.75, // Position the necklace below the face
      );

      // Draw the image on the canvas
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromCenter(
          center: scaledPosition,
          width: image.width * scaleX,
          height: image.height * scaleY,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

