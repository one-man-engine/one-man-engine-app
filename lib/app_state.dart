import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedExportType = '';
  String get selectedExportType => _selectedExportType;
  set selectedExportType(String value) {
    _selectedExportType = value;
  }

  bool _showCodeExport = true;
  bool get showCodeExport => _showCodeExport;
  set showCodeExport(bool value) {
    _showCodeExport = value;
  }

  String _ExportFormat = '';
  String get ExportFormat => _ExportFormat;
  set ExportFormat(String value) {
    _ExportFormat = value;
  }

  String _exportResult = '';
  String get exportResult => _exportResult;
  set exportResult(String value) {
    _exportResult = value;
  }

  String _exportOutput = '';
  String get exportOutput => _exportOutput;
  set exportOutput(String value) {
    _exportOutput = value;
  }

  String _MessageInput = '';
  String get MessageInput => _MessageInput;
  set MessageInput(String value) {
    _MessageInput = value;
  }

  List<dynamic> _chatMessage = [];
  List<dynamic> get chatMessage => _chatMessage;
  set chatMessage(List<dynamic> value) {
    _chatMessage = value;
  }

  void addToChatMessage(dynamic value) {
    chatMessage.add(value);
  }

  void removeFromChatMessage(dynamic value) {
    chatMessage.remove(value);
  }

  void removeAtIndexFromChatMessage(int index) {
    chatMessage.removeAt(index);
  }

  void updateChatMessageAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    chatMessage[index] = updateFn(_chatMessage[index]);
  }

  void insertAtIndexInChatMessage(int index, dynamic value) {
    chatMessage.insert(index, value);
  }

  String _aiReply = '';
  String get aiReply => _aiReply;
  set aiReply(String value) {
    _aiReply = value;
  }

  String _userPrompt = '';
  String get userPrompt => _userPrompt;
  set userPrompt(String value) {
    _userPrompt = value;
  }

  String _globalAiReply = '';
  String get globalAiReply => _globalAiReply;
  set globalAiReply(String value) {
    _globalAiReply = value;
  }

  bool _v2Ready = false;
  bool get v2Ready => _v2Ready;
  set v2Ready(bool value) {
    _v2Ready = value;
  }

  String _v2Url = '';
  String get v2Url => _v2Url;
  set v2Url(String value) {
    _v2Url = value;
  }
}
