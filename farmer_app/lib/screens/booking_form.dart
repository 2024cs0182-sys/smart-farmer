import 'package:flutter/material.dart';
import 'my_booking.dart';

class BookingFormPage extends StatefulWidget {
  final String centreName;
  final String selectedSlot;

  const BookingFormPage({
    super.key,
    required this.centreName,
    required this.selectedSlot,
  });

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final TextEditingController quantityController = TextEditingController();

  String selectedCrop = 'Paddy';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void confirmBooking() {
    if (quantityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter quantity'),
        ),
      );
      return;
    }

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

    const String bookingId = 'BK1001';
    const int token = 24;
    const String status = 'Confirmed';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyBookingPage(
          bookingId: bookingId,
          token: token,
          status: status,
          centreName: widget.centreName,
          crop: selectedCrop,
          quantity: quantity,
          slot: widget.selectedSlot,
          date:
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Slot'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Details',
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
                    const Text(
                      'Procurement Centre',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.centreName,
                      style: const TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Selected Time Slot',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.selectedSlot,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Crop',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedCrop,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grass),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Paddy',
                  child: Text('Paddy'),
                ),
                DropdownMenuItem(
                  value: 'Wheat',
                  child: Text('Wheat'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCrop = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity (kg)',
                hintText: 'Enter quantity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Procurement Date',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: selectDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: confirmBooking,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Confirm Booking',
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
}