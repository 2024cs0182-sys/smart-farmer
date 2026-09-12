import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiService {
  static String get baseUrl => ApiConfig.baseUrl;

  static Uri _uri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  // -----------------------------
  // GET nearby procurement centres
  // -----------------------------
  static Future<dynamic> getNearbyCentres(
    double latitude,
    double longitude,
  ) async {
    final response = await http.get(
      _uri(
        '/centres/nearby?latitude=$latitude&longitude=$longitude',
      ),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET centre capacity
  // -----------------------------
  static Future<dynamic> getCentreCapacity(
    int centreId,
  ) async {
    final response = await http.get(
      _uri('/centres/$centreId/capacity'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET centre slots
  // -----------------------------
  static Future<dynamic> getCentreSlots(
    int centreId,
  ) async {
    final response = await http.get(
      _uri('/centres/$centreId/slots'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // CREATE BOOKING
  // -----------------------------
  static Future<dynamic> createBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final response = await http.post(
      _uri('/booking/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(bookingData),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET BOOKING
  // -----------------------------
  static Future<dynamic> getBooking(
    int bookingId,
  ) async {
    final response = await http.get(
      _uri('/booking/$bookingId'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // DELETE BOOKING
  // -----------------------------
  static Future<dynamic> cancelBooking(
    int bookingId,
  ) async {
    final response = await http.delete(
      _uri('/booking/$bookingId'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET LIVE QUEUE
  // -----------------------------
  static Future<dynamic> getQueue(
    int token,
  ) async {
    final response = await http.get(
      _uri('/queue/$token'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // CREATE PROCUREMENT
  // -----------------------------
  static Future<dynamic> createProcurement(
    int bookingId,
    double quantityReceived,
  ) async {
    final response = await http.post(
      _uri(
        '/procurement/$bookingId'
        '?quantity_received=$quantityReceived',
      ),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET PROCUREMENT
  // -----------------------------
  static Future<dynamic> getProcurement(
    int bookingId,
  ) async {
    final response = await http.get(
      _uri('/procurement/$bookingId'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // CREATE PAYMENT
  // -----------------------------
  static Future<dynamic> createPayment(
    int bookingId,
  ) async {
    final response = await http.post(
      _uri('/payment/$bookingId'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // GET PAYMENT
  // -----------------------------
  static Future<dynamic> getPayment(
    int bookingId,
  ) async {
    final response = await http.get(
      _uri('/payment/$bookingId'),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // REGISTER FARMER
  // -----------------------------
  static Future<dynamic> registerFarmer(
    Map<String, dynamic> farmerData,
  ) async {
    final response = await http.post(
      _uri('/farmer/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(farmerData),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // FARMER LOGIN
  // -----------------------------
  static Future<dynamic> loginFarmer(
    Map<String, dynamic> loginData,
  ) async {
    final response = await http.post(
      _uri('/farmer/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginData),
    );

    return _handleResponse(response);
  }

  // -----------------------------
  // HANDLE RESPONSE
  // -----------------------------
  static dynamic _handleResponse(
    http.Response response,
  ) {
    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }

      return jsonDecode(response.body);
    }

    throw Exception(
      'API Error ${response.statusCode}: ${response.body}',
    );
  }
}