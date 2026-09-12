import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String bookingId;
  final String crop;
  final int quantity;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.crop,
    required this.quantity,
  });

  double calculatePayment() {
    const double paddyRate = 2369;
    const double wheatRate = 2585;

    final double rate = crop == 'Paddy' ? paddyRate : wheatRate;

    return (quantity / 100) * rate;
  }

  @override
  Widget build(BuildContext context) {
    final double amount = calculatePayment();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _detailRow(
                      'Booking ID',
                      bookingId,
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
                      'MSP Rate',
                      crop == 'Paddy'
                          ? '₹2369 / 100 kg'
                          : '₹2585 / 100 kg',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Text(
                      'Estimated Payment',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '₹${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Payment Status: Pending',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: const Text(
                'Payment will be processed after procurement confirmation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
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
      padding: const EdgeInsets.only(bottom: 14),
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