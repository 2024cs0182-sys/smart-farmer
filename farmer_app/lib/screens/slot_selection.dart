import 'package:flutter/material.dart';
import 'booking_form.dart';

class SlotSelectionPage extends StatelessWidget {
  final String centreName;

  const SlotSelectionPage({
    super.key,
    required this.centreName,
  });

  @override
  Widget build(BuildContext context) {
    // Temporary mock slot data.
    // Later this will come from the FastAPI backend.
    final List<Map<String, dynamic>> slots = [
      {
        'time': '09:00 AM - 10:00 AM',
        'booked': 40,
        'capacity': 50,
      },
      {
        'time': '10:00 AM - 11:00 AM',
        'booked': 25,
        'capacity': 50,
      },
      {
        'time': '11:00 AM - 12:00 PM',
        'booked': 45,
        'capacity': 50,
      },
      {
        'time': '12:00 PM - 01:00 PM',
        'booked': 50,
        'capacity': 50,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Slot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              centreName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose an available time slot',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  final slot = slots[index];

                  final int booked = slot['booked'];
                  final int capacity = slot['capacity'];
                  final int available = capacity - booked;

                  final bool isFull = available == 0;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slot['time'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Capacity: $booked / $capacity',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Available: $available',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isFull
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isFull
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingFormPage(
                                            centreName: centreName,
                                            selectedSlot:
                                                slot['time'],
                                          ),
                                        ),
                                      );
                                    },
                              child: Text(
                                isFull
                                    ? 'Slot Full'
                                    : 'Select Slot',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}