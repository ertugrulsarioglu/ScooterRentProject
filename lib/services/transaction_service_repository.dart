import 'dart:io';
import 'package:scooter_app/services/base_service_repository.dart';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class TransactionServiceRepository extends BaseServiceRepository {
  final String _controller = "Transaction";
  TransactionServiceRepository(http.Client client) : super(client);
  Future<List<Transaction>> getTransactions(userId) async {
    try {
      final response =
          await get("$_controller/GetTransactionHistories?userId=$userId");
      if (response.statusCode == HttpStatus.ok) {
        return listFromJson(response.body);
      }
      return List.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addTransactions(Transaction model) async {
    try {
      final response = await post("$_controller/AddTransactionHistory", model);
      if (response.statusCode == HttpStatus.ok) return true;
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }
}
