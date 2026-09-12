import 'package:flutter/material.dart';
import 'slot_selection.dart';

class CentreDetailsPage extends StatelessWidget {
  final String centreName;
  final int totalCapacity;
  final int bookedCapacity;

  const CentreDetailsPage({
    super.key,
    required this.centreName,
    required this.totalCapacity,
    required this.bookedCapacity,
  });

  @override
  Widget build(BuildContext context) {
    int availableCapacity = totalCapacity - bookedCapacity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centre Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              centreName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Centre Capacity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Total Capacity: $totalCapacity',
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Booked: $bookedCapacity',
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Available: $availableCapacity',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SlotSelectionPage(
                        centreName: centreName,
                      ),
                    ),
                  );
                },
                child: const Text('View Available Slots'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}