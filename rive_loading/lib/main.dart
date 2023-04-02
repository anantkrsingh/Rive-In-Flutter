import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Loading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Loading Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SMIInput<double>? progress;

  StateMachineController getController(Artboard artboard) {
    StateMachineController? stateMachineController =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(stateMachineController!);
    return stateMachineController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 200,
                height: 200,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/loading_bar.riv",
                  onInit: (artboard) {
                    StateMachineController controller = getController(artboard);
                    artboard.addController(controller);
                    progress = controller.findInput("LoadPercent");
                    progress!.value = 50.00;
                  },
                )),
            Slider(
                value: progress!.value,
                min: 0,
                max: 100,
                activeColor: Colors.grey.shade900,
                inactiveColor: Colors.grey.shade500,
                onChanged: (value) {
                  setState(() {
                    progress!.value = value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
