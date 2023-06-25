import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/is_android.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    if(kIsWeb){
      return const PublicProfileWeb();
    }
    else{
      if (isAndroid()){
        return const PublicProfileAndroid();
      }
      else{
        return const Placeholder();
      }
    }
  }
}


class PublicProfileWeb extends StatefulWidget {
  const PublicProfileWeb({super.key});

  @override
  State<PublicProfileWeb> createState() => _PublicProfileWebState();
}

class _PublicProfileWebState extends State<PublicProfileWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class PublicProfileAndroid extends StatefulWidget {
  const PublicProfileAndroid({super.key});

  @override
  State<PublicProfileAndroid> createState() => _PublicProfileAndroidState();
}

class _PublicProfileAndroidState extends State<PublicProfileAndroid> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
