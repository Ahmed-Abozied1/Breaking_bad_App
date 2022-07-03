import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp( BreakingBadApp(approuter: AppRouter()));
}

class BreakingBadApp extends StatelessWidget {

  final AppRouter approuter;
  const BreakingBadApp({ Key? key,required this.approuter }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:approuter.generateRoute ,
    );
  }
}
