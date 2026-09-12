import 'package:flutter/material.dart';
import 'payment.dart';

class ProcurementPage extends StatefulWidget {
  final int token;
  final String bookingId;
  final String crop;
  final int bookedQuantity;

  const ProcurementPage({
    super.key,
    required this.token,
    required this.bookingId,
    required this.crop,
    required this.bookedQuantity,
  });

  @override
  State<ProcurementPage> createState() => _ProcurementPageState();
}

class _ProcurementPageState extends State<ProcurementPage> {
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  void confirmProcurement() {
    final int? quantity =
        int.tryParse(quantityController.text.trim());

    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid quantity'),
        ),
      );
      return;
    }

    if (quantity > widget.bookedQuantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Quantity cannot exceed ${widget.bookedQuantity} kg',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          bookingId: widget.bookingId,
          crop: widget.crop,
          quantity: quantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procurement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Procurement Details',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow(
                      'Booking ID',
                      widget.bookingId,
                    ),
                    _detailRow(
                      'Token',
                      '${widget.token}',
                    ),
                    _detailRow(
                      'Crop',
                      widget.crop,
                    ),
                    _detailRow(
                      'Booked Quantity',
                      '${widget.bookedQuantity} kg',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Quantity Received',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity received (kg)',
                hintText: 'Enter quantity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: confirmProcurement,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Confirm Procurement',
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
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
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