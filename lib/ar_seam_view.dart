import 'package:flutter/material.dart';

import 'ar_scene_view_feature/arsceneview_config.dart';
import 'ar_scene_view_feature/augmented_image.dart';
import 'ar_scene_view_feature/depth_mode.dart';
import 'ar_scene_view_feature/instant_placement_mode.dart';
import 'ar_scene_view_feature/light_estimation_mode.dart';
import 'ar_scene_view_feature/sceneview_flutter.dart';
import 'ar_scene_view_feature/sceneview_node.dart';
import 'ar_scene_view_feature/tracking_failure_reason.dart';



class SceneViewScreen extends StatefulWidget {
  const SceneViewScreen({super.key});

  @override
  State<SceneViewScreen> createState() => _SceneViewScreenState();
}

class _SceneViewScreenState extends State<SceneViewScreen> {
  TrackingFailureReason? reason;

  bool posed = false;

  late SceneViewController sceneViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scene view example app'),
      ),
      body: Stack(
        children: [
          SceneView(
            arSceneviewConfig: ARSceneviewConfig(
              lightEstimationMode: LightEstimationMode.ambientIntensity,
              instantPlacementMode: InstantPlacementMode.disabled,
              depthMode: DepthMode.rawDepthOnly,
            ),
            augmentedImages: [
              AugmentedImage(
                name: 'rabbit',
                location: 'assets/sample_curtain.glb',
              ),
            ],
            onViewCreated: (controller) {
              print('flutter: onViewCreated');
              sceneViewController = controller;
              controller.addNode(
                SceneViewNode(
                  fileLocation: 'assets/models/MaterialSuite.glb',
                  position: KotlinFloat3(z: -1.0),
                  rotation: KotlinFloat3(x: 15),
                ),
              );
            },
            onSessionUpdated: (frame) {
              print('onSessionUpdated: $frame');
              if (!posed && frame.planes.isNotEmpty) {
                sceneViewController.addNode(
                  SceneViewNode(
                    fileLocation: 'assets/models/MaterialSuite.glb',
                    position: frame.planes.first.centerPose?.translation,
                    rotation: frame.planes.first.centerPose?.rotation,
                  ),
                );
                posed = true;
              }
            },
            onTrackingFailureChanged: (reason) {
              print('onTrackingFailureChanged: $reason');
              if (this.reason != reason) {
                setState(() {
                  this.reason = reason;
                });
              }
            },
          ),
          if (reason != null && reason != TrackingFailureReason.NONE)
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                reason!.name,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
        ],
      ),
    );
  }
}
