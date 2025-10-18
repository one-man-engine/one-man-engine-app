import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';

dynamic extractTextFromAPI(String? jsonBody) {
  String? extractTextFromAPI(String? jsonBody) {
    try {
      // Decode the incoming JSON string
      final Map<String, dynamic> data = jsonDecode(jsonBody!);

      // Prepare the result object
      final Map<String, dynamic> result = {
        'status': 'received',
        'original': data,
        'message': 'Processed successfully',
      };

      // Encode and return result as JSON string
      return jsonEncode(result);
    } catch (e) {
      // On error, return error details
      return jsonEncode({
        'status': 'error',
        'message': e.toString(),
      });
    }
  }
}

List<dynamic>? addChatMessage(
  List<dynamic>? currentMessages,
  String newText,
) {
  List<dynamic> addChatMessage(List<dynamic> currentMessages, String newText) {
    final newMessage = {
      "text": newText,
      "user": "ai",
    };

    final updatedMessages =
        List<Map<String, dynamic>>.from(currentMessages ?? []);
    updatedMessages.add(newMessage);

    return updatedMessages;
  }
}
