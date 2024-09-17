import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTicket(Map<String, dynamic> ticketData) async {
    await _firestore.collection('TicketAvion').add(ticketData);
    notifyListeners();
  }

  Future<void> updateTicket(String id, Map<String, dynamic> ticketData) async {
    await _firestore.collection('TicketAvion').doc(id).update(ticketData);
    notifyListeners();
  }

  Future<void> deleteTicket(String id) async {
    await _firestore.collection('TicketAvion').doc(id).delete();
    notifyListeners();
  }

  Stream<QuerySnapshot> getTickets() {
    return _firestore.collection('TicketAvion').snapshots();
  }
}
