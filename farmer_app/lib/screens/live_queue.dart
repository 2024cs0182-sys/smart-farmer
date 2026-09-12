import 'package:flutter/material.dart';
import 'procurement.dart';

class LiveQueuePage extends StatefulWidget {
  final int token;

  const LiveQueuePage({
    super.key,
    required this.token,
  });

  @override
  State<LiveQueuePage> createState() => _LiveQueuePageState();
}

class _LiveQueuePageState extends State<LiveQueuePage> {
  int queuePosition = 9;
  int farmersAhead = 8;
  String alert = 'Please wait';

  void refreshQueue() {
    setState(() {
      if (farmersAhead > 0) {
        farmersAhead--;
        queuePosition--;

        if (farmersAhead <= 0) {
          alert = 'Your turn';
        } else if (farmersAhead <= 5) {
          alert = 'Your turn is near';
        } else {
          alert = 'Please wait';
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Queue updated'),
      ),
    );
  }

  void openProcurement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProcurementPage(
          token: widget.token,
          bookingId: 'BK1001',
          crop: 'Paddy',
          bookedQuantity: 100,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Queue'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Live Queue Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Your Token',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${widget.token}',
                        style: const TextStyle(
                          fontSize: 48,
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
                  children: [
                    _queueRow(
                      'Queue Position',
                      '$queuePosition',
                    ),
                    const Divider(),
                    _queueRow(
                      'Farmers Ahead',
                      '$farmersAhead',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: Column(
                children: [
                  const Text(
                    'Queue Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    alert,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: refreshQueue,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Refresh Queue',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: openProcurement,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Go to Procurement',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _queueRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}