import 'package:flutter/material.dart';
import 'package:flutter_signature/custom_dialog.dart';
import 'package:hand_signature/signature.dart';


class HomeScreen extends StatelessWidget {

  final HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.85,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('D-Signature'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(),
                    color: Colors.white,
                    child: HandSignaturePainterView(
                      control: control,
                      type: SignatureDrawType.shape,
                    ),
                  ),
                  CustomPaint(
                    painter: DebugSignaturePainterCP(
                      control: control,
                      cp: false,
                      cpStart: false,
                      cpEnd: false,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      final data = await control.toImage(
                        color: Colors.black,
                        background: Colors.white
                      );

                      if (data != null) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(data),
                        );
                      }
                    },
                  ),
                  //CLEAR CANVAS
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      control.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
