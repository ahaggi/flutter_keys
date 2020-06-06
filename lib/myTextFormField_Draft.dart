import 'dart:collection';

import 'package:flutter/material.dart';

class MyTextFormField_draft extends StatefulWidget {
  MyTextFormField_draft({
    this.label,
    this.autovalidate = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.fieldKey,
    this.orderIndex,  
    this.onSaved,
    this.validateInput,
    this.changeToNextFocusNode,
    this.addOrRemoveFromInvalidNodes,
    this.attachToTextControllerMap,
    this.removeFromTextControllerMap,
    this.attachToFocusNodeMap,
    this.removeFromFocusNodeMap,
    this.addListnersToFocusNode,
    this.addListnersToTextController,
  }) ;

 
  final String label;
  final String fieldKey;
  final bool autovalidate;
  final bool enabled;
  final double orderIndex;
  final TextInputType keyboardType;
  final MCdynamicDynamic validateInput;
  final MCDynamicVoid changeToNextFocusNode;
  final MC3Dynamicvoid addOrRemoveFromInvalidNodes;
  final MCDynamicVoid onSaved;
  final MC2Dynamicvoid attachToTextControllerMap;
  final MCDynamicVoid removeFromTextControllerMap;
  final MC2Dynamicvoid attachToFocusNodeMap;
  final MCDynamicVoid removeFromFocusNodeMap;
  final List<dynamic> addListnersToTextController;
  final List<dynamic> addListnersToFocusNode;

  @override
  _MyTextFormField_draftState createState() => _MyTextFormField_draftState();
}

class _MyTextFormField_draftState extends State<MyTextFormField_draft> {
  TextEditingController textController;
  FocusNode focusNode;

  List<dynamic> list = [];

  @override
  void initState() {
    textController = TextEditingController();
    if (widget.attachToTextControllerMap != null)
      widget.attachToTextControllerMap(widget.fieldKey, textController);

    if (widget.addListnersToTextController != null &&
        widget.addListnersToTextController.isNotEmpty)
      widget.addListnersToTextController.forEach((fn) {
        textController.removeListener(fn);
        textController.addListener(fn);
      });

    focusNode = FocusNode(debugLabel: widget.label);
    if (widget.attachToFocusNodeMap != null)
      widget.attachToFocusNodeMap(widget.fieldKey, focusNode);

    if (widget.addListnersToFocusNode != null &&
        widget.addListnersToFocusNode.isNotEmpty)
      widget.addListnersToFocusNode.forEach((fn) {
        focusNode.removeListener(fn);
        focusNode.addListener(fn);
      });

    super.initState();
  }

  @override
  void dispose() {
    print(
        "€€€€dispose€€€€    €€€€dispose€€€€    ${widget.label}    ${widget.fieldKey}  €€€€dispose€€€€    €€€€dispose€€€€");


    if (widget.removeFromTextControllerMap != null)
      widget.removeFromTextControllerMap(widget.fieldKey);

    if (widget.removeFromFocusNodeMap != null)
      widget.removeFromFocusNodeMap(widget.fieldKey);

    widget.addListnersToTextController.forEach((fn) {
      textController.removeListener(fn);
    });

    widget.addListnersToFocusNode.forEach((fn) {
      focusNode.removeListener(fn);
    });

    textController.dispose();

    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "¤¤¤¤¤build¤¤¤¤    ¤¤¤¤¤build¤¤¤¤    ${widget.label}    ${widget.fieldKey}    ¤¤¤¤¤build¤¤¤¤    ¤¤¤¤¤¤¤¤¤¤¤");
    return TextFormField(

      keyboardType: widget.keyboardType,
      autovalidate: widget.autovalidate,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: 14.0),
      ),
      enabled: widget.enabled,
      controller: textController,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (str) {
        if (widget.changeToNextFocusNode != null)
          widget.changeToNextFocusNode(widget.fieldKey);
      },
      validator: (str) {
        String err = widget.validateInput(str);
        bool valid = err == null;
        if (focusNode != null && widget.orderIndex != null)
          widget.addOrRemoveFromInvalidNodes(
              valid, focusNode, widget.orderIndex);
        return err;
      },
      onSaved: widget.onSaved,
    );
  }
}

typedef void MCvoidVoid();

// void => dynamic
typedef dynamic MCvoidDynamic();

// dynamic => void
typedef void MCDynamicVoid(param1);

// dynamic => dynamic
typedef dynamic MCdynamicDynamic(param1);

// dynamic dynamic => void
typedef void MC2Dynamicvoid(param1, param2);

// dynamic dynamic => dynamic
typedef dynamic MC2DynamicDynamic(param1, param2);

// dynamic dynamic dynamic => void
typedef void MC3Dynamicvoid(param1, param2, param3);

// dynamic dynamic dynamic => dynamic
typedef dynamic MC3DynamicDynamic(param1, param2, param3);
