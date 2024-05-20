import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

class StateManagementClass extends StatelessWidget {
  final child;
  const StateManagementClass({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider()),
    ], child: child);
  }
}
