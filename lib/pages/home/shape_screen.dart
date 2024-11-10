// import 'dart:async';
// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:ui';

// import 'package:camera/camera.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image/image.dart' as img;

// List<CameraDescription>? cameras;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController controller;
//   final faceDetector = GoogleMlKit.vision.faceDetector();

//   @override
//   void initState() {
//     super.initState();
//     var frontCamera = cameras
//         ?.where((c) => c.lensDirection == CameraLensDirection.front)
//         .first;
//     controller = CameraController(frontCamera!, ResolutionPreset.high);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text('Place your face in the box'), leading:Text(''),),
//       body: Stack(
//         children: <Widget>[
//           CameraPreview(controller),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(padding:  EdgeInsets.only(top: 100.h),
//                 child: DottedBorder(
//                   borderType:
//                       BorderType.Oval,
//                   color: const ui.Color.fromARGB(255, 0, 255, 225), 
//                   strokeWidth: 3.sp, 
//                   dashPattern: const [6, 3], 
//                   padding: const EdgeInsets.all(6), 
//                   child: ClipOval(
//                     child: SizedBox(
//                       height: 380.h, 
//                       width: 240.w, 
//                       // decoration: BoxDecoration(
//                       //   color: Colors.black, // Background color (optional)
//                       // ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Positioned(
//             bottom: 30.0,
//             left: 0.0,
//             right: 0.0,
//             child: Center(
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   await _captureAndProcessImage(context);
//                 },
//                 tooltip: 'Capture Image',
//                 child: const Icon(CupertinoIcons.camera),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _captureAndProcessImage(BuildContext context) async {
//     try {
//       final image = await controller.takePicture();

//       // Process the image for face detection
//       final inputImage = InputImage.fromFilePath(image.path);
//       final List<Face> faces = await faceDetector.processImage(inputImage);

//       print("Detected ${faces.length} faces");

//       // Navigate to the next screen to display the image with circles
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 DisplayImageScreen(faces: faces, imagePath: image.path)),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }

// class DisplayImageScreen extends StatefulWidget {
//   final List<Face> faces;
//   final String imagePath;

//   const DisplayImageScreen({
//     super.key,
//     required this.faces,
//     required this.imagePath,
//   });

//   @override
//   _DisplayImageScreenState createState() => _DisplayImageScreenState();
// }

// class _DisplayImageScreenState extends State<DisplayImageScreen> {
//   late Future<ui.Image> _backgroundImageFuture;

//   @override
//   void initState() {
//     super.initState();
//     _backgroundImageFuture = loadBackgroundImage();
//   }

//   Future<ui.Image> loadBackgroundImage() async {
//     final Completer<ui.Image> completer = Completer<ui.Image>();
//     rootBundle.load('asset/thali_nobg.png').then((byteData) async {
//       final Uint8List bytes = byteData.buffer.asUint8List();
//       final img.Image? decodedImage = img.decodeImage(bytes);
//       if (decodedImage != null) {
//         // Convert img.Image to ui.Image
//         final ui.Codec codec = await ui.instantiateImageCodec(bytes);
//         final ui.FrameInfo frameInfo = await codec.getNextFrame();
//         final ui.Image image = frameInfo.image;

//         // Calculate new width and height with desired scaling factors
//         const double scaleFactorWidth = 0.66; // Reduce width by 4%
//         const double scaleFactorHeight = 0.67; // Reduce height by 70%

//         final int scaledWidth = (image.width * scaleFactorWidth).round();
//         final int scaledHeight = (image.height * scaleFactorHeight).round();

//         final ui.PictureRecorder recorder = ui.PictureRecorder();
//         final Canvas canvas = Canvas(recorder);

//         canvas.scale(scaledWidth.toDouble() / image.width.toDouble(),
//             scaledHeight.toDouble() / image.height.toDouble());
//         canvas.drawImage(image, Offset.zero, Paint());

//         final ui.Image uiImage =
//             await recorder.endRecording().toImage(scaledWidth, scaledHeight);
//         completer.complete(uiImage);
//       }
//     });
//     return completer.future;
//   }

// // Future<ui.Image> loadBackgroundImage() async {
// //   final Completer<ui.Image> completer = Completer<ui.Image>();
// //   rootBundle.load('asset/thali_nobg.png').then((byteData) async {
// //     final Uint8List bytes = byteData.buffer.asUint8List();
// //     final img.Image? decodedImage = img.decodeImage(bytes);
// //     if (decodedImage != null) {
// //       // Convert img.Image to ui.Image
// //       final ui.Codec codec = await ui.instantiateImageCodec(bytes);
// //       final ui.FrameInfo frameInfo = await codec.getNextFrame();
// //       final ui.Image image = frameInfo.image;

// //       final ui.PictureRecorder recorder = ui.PictureRecorder();
// //       final Canvas canvas = Canvas(recorder);

// //       final int width = image.width;
// //       final int height = image.height;
// //       canvas.scale(width.toDouble() / image.width.toDouble(),
// //           height.toDouble() / image.height.toDouble()*.8);
// //       canvas.drawImage(image, Offset.zero, Paint());

// //       final ui.Image uiImage = await recorder.endRecording().toImage(width, height);
// //       completer.complete(uiImage);
// //     }
// //   });
// //   return completer.future;
// // }

//   @override
//   Widget build(BuildContext context) {
//     var facePositions = calculateFacePositions(widget.faces,
//         MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Captured Image')),
//       body: Center(
//         child: Stack(
//           children: [
//             Image.file(File(widget.imagePath)),
//             FutureBuilder<ui.Image>(
//               future: _backgroundImageFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return const Text('Error loading image');
//                   } else {
//                     return CustomPaint(
//                       painter: FacePainter(facePositions,
//                           backgroundImage:
//                               snapshot.data!), // Use the loaded image
//                       size: Size(MediaQuery.of(context).size.width,
//                           MediaQuery.of(context).size.height),
//                     );
//                   }
//                 } else {
//                   // While waiting for the image to load, show a placeholder or something similar
//                   return const CircularProgressIndicator();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// // Speculative approach: Assuming FaceLandmark might contain a method or property to access coordinates
// // This is a placeholder and needs to be replaced with the actual method or property based on your library's documentation

//   List<Offset> calculateFacePositions(
//       List<Face> faces, double originalImageWidth, double screenWidth) {
//     List<Offset> facePositions = [];

//     for (Face face in faces) {
//       Offset chinOrNeckPosition = Offset.zero;

//       for (var entry in face.landmarks.entries) {
//         // Hypothetically accessing coordinates, replace with actual method or property
//         var landmarkCoordinates = entry.value?.position; // Placeholder method
//         if (landmarkCoordinates != null &&
//             landmarkCoordinates.y > chinOrNeckPosition.dy) {
//           chinOrNeckPosition = Offset(landmarkCoordinates.x.toDouble(),
//               landmarkCoordinates.y.toDouble());
//         }
//       }

//       double scaleX = screenWidth / originalImageWidth;
//       double scaleY = screenWidth / originalImageWidth;

//       double centerX = chinOrNeckPosition.dx +
//           (face.boundingBox.right - face.boundingBox.left) * scaleX * .100;
//       double centerY = chinOrNeckPosition.dy +
//           (face.boundingBox.bottom - face.boundingBox.top) * scaleY * .65;

//       facePositions.add(Offset(centerX, centerY));
//     }

//     return facePositions;
//   }
// }

// // class _DisplayImageScreenState extends State<DisplayImageScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //    late Future<ui.Image> backgroundImageFuture;
// //     //

// //     var facePositions = calculateFacePositions(widget.faces,
// //         MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);

// //     // Load the asset image asynchronously
// //     final Completer<ui.Image> completer = Completer<ui.Image>();
// //     rootBundle.load('asset/thali_nobg.png').then((byteData) async {
// //       final Uint8List bytes = byteData.buffer.asUint8List();
// //       final img.Image? decodedImage = img.decodeImage(bytes);
// //       if (decodedImage != null) {
// //         // Create a bitmap buffer
// //         final ui.PictureRecorder recorder = ui.PictureRecorder();
// //         final Canvas canvas = Canvas(recorder);

// //         // Set up the canvas with the decoded image
// //         final int width = decodedImage.width;
// //         final int height = decodedImage.height;
// //         canvas.scale(width.toDouble() / decodedImage.width.toDouble(),
// //             height.toDouble() / decodedImage.height.toDouble());
// //         canvas.drawImage(decodedImage as ui.Image, Offset.zero, Paint());

// //         // Convert the picture recorder to a ui.Image
// //         final ui.Image image =
// //             await recorder.endRecording().toImage(width, height);
// //         completer.complete(image);
// //       }
// //     });

// //       final ui.Image backgroundImage = await completer.future;

// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Captured Image')),
// //       body: Center(
// //         child: Stack(
// //           children: [
// //             Image.file(File(widget.imagePath)),
// //             // ContainerCustom(
// //             //   marginLeft: facePositions[0].dy * .14,
// //             //   marginTop: facePositions[0].dx * 2.5,
// //             //   height: facePositions[0].dx * .3,
// //             //   width: facePositions[0].dy * .4,
// //             //   bgColor: Colors.amber,
// //             // ),
// //             IgnorePointer(
// //               child: CustomPaint(
// //                 painter: FacePainter(facePositions,
// //                     backgroundImage:backgroundImage),
// //                 size: Size(MediaQuery.of(context).size.width,
// //                     MediaQuery.of(context).size.height),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// // List<Offset> calculateFacePositions(
// //     List<Face> faces, double originalImageWidth, double screenWidth) {
// //   List<Offset> facePositions = [];

// //   for (Face face in faces) {
// //     double scaleX = screenWidth / originalImageWidth;
// //     double scaleY = screenWidth /
// //         originalImageWidth; // Assuming square aspect ratio for simplicity

// //     double centerX = face.boundingBox.left +
// //         (face.boundingBox.right - face.boundingBox.left) * scaleX / 5.3;
// //     double centerY = face.boundingBox.top +
// //         (face.boundingBox.bottom - face.boundingBox.top) * scaleY / 1.35;

// //     facePositions.add(Offset(centerX, centerY));
// //   }

// //   return facePositions;
// // }
// // }

// class FacePainter extends CustomPainter {
//   final List<Offset> facePositions;
//   final ui.Image backgroundImage;

//   FacePainter(this.facePositions, {required this.backgroundImage});

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw the background image
//     final Paint paint = Paint();
//     canvas.drawImage(backgroundImage, facePositions[0], paint);

//     // Optionally, draw faces positions here
//     // for (var position in facePositions) {
//     //   canvas.drawCircle(position, 10, Paint()..color = Colors.red);
//     // }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
