import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    api.authenticate("NielsVM", "Develop1");

    return Scaffold(
      body: 
          FutureBuilder(
          future: api.fetchAllPasswords(),
          builder: (BuildContext context, AsyncSnapshot<List<PasswordModel>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<Widget> wList = [];
            snapshot.data.forEach((e) => {
              wList.add(Password(model:e))
            });
            return Column(children: wList);
          },
        ),
    );
  }
}
