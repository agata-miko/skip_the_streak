import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings), // Settings icon
                onPressed: () {
                  // Open the drawer when settings icon is tapped
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(color: Color(0xff49672d)),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.about1),
              Text(AppLocalizations.of(context)!.about2),
            ],
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'lib/assets/images/about_image.png',
              fit: BoxFit.cover,
            )),
      ]),
    );
  }
}
