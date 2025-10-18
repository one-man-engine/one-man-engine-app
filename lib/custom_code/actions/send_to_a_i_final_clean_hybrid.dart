// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendToAIFinalCleanHybrid(String userMessage) async {
  try {
    final trimmed = userMessage.trim().toLowerCase();

    // Route commands to Firebase
    if (trimmed.contains('build') ||
        trimmed.contains('status') ||
        trimmed.contains('export')) {
      final firebaseUrl = Uri.parse(
        'https://us-central1-onemanengine-9c23b.cloudfunctions.net/sendToDrew',
      );
      final firebaseHeaders = {'Content-Type': 'application/json'};
      final firebaseBody = jsonEncode({'message': userMessage});

      final firebaseResponse = await http.post(firebaseUrl,
          headers: firebaseHeaders, body: firebaseBody);

      if (firebaseResponse.statusCode == 200) {
        final decoded = jsonDecode(firebaseResponse.body);
        return (decoded['reply'] ?? 'Drew received your command.')
            .toString()
            .trim();
      } else {
        return 'Error contacting Drew (status: ${firebaseResponse.statusCode}).';
      }
    }

    // Call OpenAI API for everything else
    final openaiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');
    final openaiHeaders = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    };
    final openaiBody = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': userMessage}
      ],
    });

    final openaiResponse =
        await http.post(openaiUrl, headers: openaiHeaders, body: openaiBody);

    if (openaiResponse.statusCode == 200) {
      final decoded = jsonDecode(openaiResponse.body);
      final msg = decoded['choices']?[0]?['message']?['content'] ?? 'No reply';
      return msg.toString().trim();
    } else {
      return 'Failed to fetch response from AI (status: ${openaiResponse.statusCode}).';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
