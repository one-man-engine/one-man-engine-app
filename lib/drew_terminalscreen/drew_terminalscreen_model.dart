import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'drew_terminalscreen_widget.dart' show DrewTerminalscreenWidget;
import 'package:flutter/material.dart';

class DrewTerminalscreenModel
    extends FlutterFlowModel<DrewTerminalscreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for userPromptTextField widget.
  FocusNode? userPromptTextFieldFocusNode;
  TextEditingController? userPromptTextFieldTextController;
  String? Function(BuildContext, String?)?
      userPromptTextFieldTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - sendToAIFinalCleanHybrid] action in Button widget.
  String? aiReply;
  // Stores action output result for [Firestore Query - Query a collection] action in update widget.
  JobsRecord? lastBuilt;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userPromptTextFieldFocusNode?.dispose();
    userPromptTextFieldTextController?.dispose();
  }
}
