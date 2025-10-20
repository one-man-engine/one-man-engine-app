import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'terminalpage_widget.dart' show TerminalpageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TerminalpageModel extends FlutterFlowModel<TerminalpageWidget> {
  ///  Local state fields for this page.

  String aiReply = 'empty';

  ///  State fields for stateful widgets in this page.

  // State field(s) for userPromptTextField widget.
  FocusNode? userPromptTextFieldFocusNode;
  TextEditingController? userPromptTextFieldTextController;
  String? Function(BuildContext, String?)?
      userPromptTextFieldTextControllerValidator;
  // Stores action output result for [Custom Action - sendToAIFinalCleanHybrid] action in Button widget.
  String? backFromAi;
  // Stores action output result for [Custom Action - sendToAIFinalCleanHybrid] action in Button widget.
  String? backFromai;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userPromptTextFieldFocusNode?.dispose();
    userPromptTextFieldTextController?.dispose();
  }
}
