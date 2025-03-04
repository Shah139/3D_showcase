import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AeroViewerScreen extends StatelessWidget {
  const AeroViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aero Models'),
      ),
      body: // In your AeroViewerScreen
StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  stream: FirebaseFirestore.instance
      .collection('Plane')
      .doc('aero')
      .snapshots(),
  builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!snapshot.hasData || !snapshot.data!.exists) {
      return const Center(
        child: Text('No model available'),
      );
    }

    final modelData = AeroModel(
      name: snapshot.data!.get('name') ?? '',
      description: snapshot.data!.get('description') ?? '',
      url: snapshot.data!.get('url') ?? '',
    );

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 600,
            child: ModelViewer(
              src: modelData.url,
              alt: modelData.name,
              ar: true,
              autoRotate: true,
              cameraControls: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelData.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  modelData.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
)
    );
  }
}

class AeroModel {
  final String name;
  final String description;
  final String url;

  AeroModel({
    required this.name,
    required this.description,
    required this.url,
  });

  factory AeroModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return AeroModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      url: data['url'] ?? '',
    );
  }
}