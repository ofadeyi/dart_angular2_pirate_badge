import 'dart:math' show Random;
import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:http/browser_client.dart';

@Injectable()
class NameService {
  static const _namesPath = 'piratenames.json';
  static final Random _indexGen = new Random();
  final List _names = <String>[];
  final List _appellations = <String>[];
  final BrowserClient _http;

  NameService(this._http);

  String _randomFirstName() => _names[_indexGen.nextInt(_names.length)];

  String _randomAppellation() =>
      _appellations[_indexGen.nextInt(_appellations.length)];

  String getPirateName(String firstName) {
    if (firstName == null || firstName
        .trim()
        .isEmpty) {
      firstName = _randomFirstName();
    }

    return '$firstName the ${_randomAppellation()}';
  }

  Future<Null> readyThePirates() async {
    if (_names.isNotEmpty && _appellations.isNotEmpty) return;

    try {
      final response = await _http.get(_namesPath);
      final pirateNames = JSON.decode(response.body);
      _names.addAll(pirateNames['names']);
      _appellations.addAll(pirateNames['appellations']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // log to console instead
    return new Exception('Server error; cause: $e');
  }
}