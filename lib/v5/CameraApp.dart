import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Wrapper widget that handles camera initialization
class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: availableCameras(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return CameraAppWidget(cameras: snapshot.data!);
      },
    );
  }
}

/// CameraApp is the Main Application.
class CameraAppWidget extends StatefulWidget {
  /// Default Constructor
  const CameraAppWidget({super.key, required this.cameras});

  final List<CameraDescription> cameras; // Store cameras

  @override
  State<CameraAppWidget> createState() => _CameraAppWidgetState();
}

class _CameraAppWidgetState extends State<CameraAppWidget> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    // Access cameras from the widget's properties
    if (widget.cameras.isEmpty) {
      // Handle the case where no cameras are available,
      // though availableCameras() should ideally not return an empty list
      // if cameras are present and permissions are granted.
      // You might want to show an error message or a placeholder.
      print("No cameras found!");
      return;
    }
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                print("Camera access denied: ${e.description}");
                break;
              default:
                // Handle other errors here.
                print("Camera error: ${e.code} ${e.description}");
                break;
            }
          } else {
            print("An unexpected error occurred: $e");
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the controller is initialized AND if cameras were available
    if (widget.cameras.isEmpty || !controller.value.isInitialized) {
      // Show a loading indicator or an error message if cameras are not available
      // or the controller is not yet initialized.
      return const Scaffold(
        appBar: null,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Preview')),
      body: CameraPreview(controller),
    );
  }
}
