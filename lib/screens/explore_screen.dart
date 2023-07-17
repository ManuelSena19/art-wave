import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/is_android.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if(kIsWeb){
      return const ExploreScreenWeb();
    }
    else{
      if(isAndroid()){
        return const ExploreScreenAndroid();
      }
      else{
        return const Placeholder();
      }
    }
  }
}

class ExploreScreenWeb extends StatefulWidget {
  const ExploreScreenWeb({super.key});

  @override
  State<ExploreScreenWeb> createState() => _ExploreScreenWebState();
}

class _ExploreScreenWebState extends State<ExploreScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExploreScreenAndroid extends StatefulWidget {
  const ExploreScreenAndroid({super.key});

  @override
  State<ExploreScreenAndroid> createState() => _ExploreScreenAndroidState();
}

class _ExploreScreenAndroidState extends State<ExploreScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


