import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import 'live_queue.dart';

class MyBookingPage extends StatelessWidget {
  final String bookingId;
  final int token;
  final String status;
  final String centreName;
  final String crop;
  final int quantity;
  final String slot;
  final String date;

  const MyBookingPage({
    super.key,
    required this.bookingId,
    required this.token,
    required this.status,
    required this.centreName,
    required this.crop,
    required this.quantity,
    required this.slot,
    required this.date,
  });

  Future<void> saveBookingOffline() async {
    await LocalStorage.saveData('booking_id', bookingId);
    await LocalStorage.saveData('token', token);
    await LocalStorage.saveData('status', status);
    await LocalStorage.saveData('centre_name', centreName);
    await LocalStorage.saveData('crop', crop);
    await LocalStorage.saveData('quantity', quantity);
    await LocalStorage.saveData('slot', slot);
    await LocalStorage.saveData('date', date);
  }

  @override
  Widget build(BuildContext context) {
    saveBookingOffline();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Confirmed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.offline_pin,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Booking saved offline',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Your Token Number',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$token',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        status,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),

                    _detailRow(
                      'Booking ID',
                      bookingId,
                    ),
                    _detailRow(
                      'Centre',
                      centreName,
                    ),
                    _detailRow(
                      'Crop',
                      crop,
                    ),
                    _detailRow(
                      'Quantity',
                      '$quantity kg',
                    ),
                    _detailRow(
                      'Date',
                      date,
                    ),
                    _detailRow(
                      'Time Slot',
                      slot,
                    ),
                    _detailRow(
                      'Status',
                      status,
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
                      builder: (context) => LiveQueuePage(
                        token: token,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'View Live Queue',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}