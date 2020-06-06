import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import 'myTextFormField_Draft.dart';

class TheStateful1 extends StatefulWidget {
  TheStateful1({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _TheStateful1State createState() => _TheStateful1State();
}

class _TheStateful1State extends State<TheStateful1> {
  Map<String, dynamic> valuesState = {
    "key1": {"pris": "", "totalPris": ""},
    "key2": {"pris": "", "totalPris": ""},
    "key3": {"pris": "", "totalPris": ""},
    "key4": {"pris": "", "totalPris": ""},
  };
  Map<dynamic, dynamic> txtCtrlMap;

  Map<dynamic, dynamic> tempfocusNodeMap;
  SplayTreeMap<dynamic, dynamic> focusNodeMap;

  @override
  void initState() {
    super.initState();

    txtCtrlMap = Map<dynamic, dynamic>();

    tempfocusNodeMap = Map<dynamic, dynamic>();
    focusNodeMap =
        SplayTreeMap<dynamic, dynamic>.from(tempfocusNodeMap, (a, b) {
      return tempfocusNodeMap[a]["z_index"]
          .compareTo(tempfocusNodeMap[b]["z_index"]);
    });
  }

  void attachToTextControllerMapHandler(stateKey, txtCtrl) {
    txtCtrlMap[stateKey] = txtCtrl;
  }

  void removeFromTextControllerMapHandler(stateKey) {
    txtCtrlMap.remove(stateKey);
  }

  void attachToFocusNodeMapHandler(fieldKey, focusNode) {
    Map<String, dynamic> m0 = {
      "z_index": tempfocusNodeMap.length.toDouble(),
      "node": focusNode,
    };

    tempfocusNodeMap.putIfAbsent(fieldKey, () => m0);

    // var z_index = focusNodeMap[fieldKey]["z_index"];
    focusNodeMap.putIfAbsent(fieldKey, () => m0);
    // focusNodeMap[fieldKey]["node"] = focusNode;
    if (1 == 1) ;
  }

  void removeFromFocusNodeMapHandler(stateKey) {
    focusNodeMap.remove(stateKey);
    tempfocusNodeMap.remove(stateKey);
  }

  Widget getItem({
    String rowKey,
    String prisFieldKey,
    String totalPrisFieldKey,
    Color color,
  }) => //
      Container(
        /// move the key to the (MyTextFormField_draft-level) or the (column-level) and enjoy the bugs
        /// https://medium.com/flutter/keys-what-are-they-good-for-13cb51742e7d
        key: ValueKey(rowKey),
        color: color,
        child: Column(
          children: <Widget>[
            MyTextFormField_draft(
              // key: ValueKey(prisFieldKey), Ikke nødvendig
              label: rowKey + "  Pris",
              fieldKey: prisFieldKey,
              attachToTextControllerMap: attachToTextControllerMapHandler,
              removeFromTextControllerMap: removeFromTextControllerMapHandler,
              attachToFocusNodeMap: attachToFocusNodeMapHandler,
              removeFromFocusNodeMap: removeFromFocusNodeMapHandler,
              addListnersToTextController: [
                () => print(
                    " txtCtrl:$prisFieldKey ${txtCtrlMap[prisFieldKey].text}")
              ],
              addListnersToFocusNode: [
                () {
                  FocusNode focusnode = focusNodeMap[prisFieldKey]["node"];
                  if (focusnode.hasFocus)
                    print(
                        "${focusNodeMap[totalPrisFieldKey]["node"].debugLabel} got focus");
                }
              ],
            ),
            MyTextFormField_draft(
              // key: ValueKey(totalPrisFieldKey), Ikke nødvendig
              label: rowKey + "  TotalPris",
              fieldKey: totalPrisFieldKey,
              attachToTextControllerMap: attachToTextControllerMapHandler,
              removeFromTextControllerMap: removeFromTextControllerMapHandler,
              attachToFocusNodeMap: attachToFocusNodeMapHandler,
              removeFromFocusNodeMap: removeFromFocusNodeMapHandler,
              addListnersToTextController: [
                () => print(
                    " txtCtrl:$totalPrisFieldKey ${txtCtrlMap[totalPrisFieldKey].text}")
              ],
              addListnersToFocusNode: [
                () {
                  FocusNode focusnode = focusNodeMap[totalPrisFieldKey]["node"];
                  if (focusnode.hasFocus)
                    print(
                        "${focusNodeMap[totalPrisFieldKey]["node"].debugLabel} got focus");
                }
              ],
            ),
            FlatButton(
              onPressed: () {
                valuesState.remove(rowKey);
                setState(() {});
              },
              child: Text('Remove'),
            )
          ],
        ),
      );

  Widget _createItemListView(Map<String, dynamic> map) {
    List<dynamic> _keys = (valuesState.keys).toList();
    var rnd = Random();

    List<Widget> items = List.generate(_keys.length, (index) {
      String rowKey = _keys[index];
      String prisFieldKey = rowKey + "Pris";
      String totalPrisFieldKey = rowKey + "totalPris";

      return getItem(
        rowKey: rowKey,
        prisFieldKey: prisFieldKey,
        totalPrisFieldKey: totalPrisFieldKey,
        color: generateRandomColor(rand: rnd),
      );
    });

    return ListView(
      children: items,
    );
  }

  Widget _createItemListViewWithBuilder(Map<String, dynamic> map) {
    ///
    ///Why this code is buggs buggy? Even if we use keys
    ///
    ///becuase [ListView.builder] by default does not support child reordering.
    ///If you are planning to change child order at a later time, consider using [ListView] or [ListView.custom].

    List<dynamic> _keys = (valuesState.keys).toList();
    var rnd = Random();

    return ListView.builder(
      itemCount: _keys.length,
      itemBuilder: (_, int index) {
        String rowKey = _keys[index];
        String prisFieldKey = rowKey + "Pris";
        String totalPrisFieldKey = rowKey + "totalPris";

        return getItem(
          rowKey: rowKey,
          prisFieldKey: prisFieldKey,
          totalPrisFieldKey: totalPrisFieldKey,
          color: generateRandomColor(rand: rnd),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _createItemListView(valuesState)
        // _createItemListViewWithBuilder(valuesState)

        );
  }
}

dynamic generateRandomColor({rand}) {
  if (rand == null) print("wtf!");
  int r = int.parse((rand.nextInt(100) * 10000).toString(), radix: 16);
  int b = int.parse((rand.nextInt(100) * 100).toString(), radix: 16);
  int g = int.parse((rand.nextInt(100)).toString(), radix: 16);

  var res = (0x7F800000 + r + b + g);
  if (res > 0xffffffff)
    print("$res is lt 0xffffffff !!!!!!!!!");
  else
    print("$res OK!");

  // return {"rand":rand , "color":Color(res)};
  return Color(res);
}
