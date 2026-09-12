import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/centre_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const SmartFarmerApp());
}

class SmartFarmerApp extends StatelessWidget {
  const SmartFarmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farmer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CentresPage(),
    );
  }
}

class CentresPage extends StatefulWidget {
  const CentresPage({super.key});

  @override
  State<CentresPage> createState() => _CentresPageState();
}

class _CentresPageState extends State<CentresPage> {
  GoogleMapController? mapController;

  final LatLng farmerLocation = const LatLng(13.0827, 80.2707);

  final Set<Marker> markers = {
    Marker(
      markerId: const MarkerId('centre_1'),
      position: const LatLng(13.0878, 80.2785),
      infoWindow: const InfoWindow(
        title: 'Procurement Centre 1',
        snippet: 'Capacity: 350 / 500',
      ),
      onTap: () {},
    ),
    Marker(
      markerId: const MarkerId('centre_2'),
      position: const LatLng(13.0674, 80.2376),
      infoWindow: const InfoWindow(
        title: 'Procurement Centre 2',
        snippet: 'Capacity: 220 / 500',
      ),
      onTap: () {},
    ),
  };

  void openCentreDetails(
    String centreName,
    int totalCapacity,
    int bookedCapacity,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CentreDetailsPage(
          centreName: centreName,
          totalCapacity: totalCapacity,
          bookedCapacity: bookedCapacity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> updatedMarkers = {
      Marker(
        markerId: const MarkerId('centre_1'),
        position: const LatLng(13.0878, 80.2785),
        infoWindow: const InfoWindow(
          title: 'Procurement Centre 1',
          snippet: 'Capacity: 350 / 500',
        ),
        onTap: () {
          openCentreDetails(
            'Procurement Centre 1',
            500,
            350,
          );
        },
      ),
      Marker(
        markerId: const MarkerId('centre_2'),
        position: const LatLng(13.0674, 80.2376),
        infoWindow: const InfoWindow(
          title: 'Procurement Centre 2',
          snippet: 'Capacity: 220 / 500',
        ),
        onTap: () {
          openCentreDetails(
            'Procurement Centre 2',
            500,
            220,
          );
        },
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Procurement Centres'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: farmerLocation,
          zoom: 12,
        ),
        markers: updatedMarkers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}