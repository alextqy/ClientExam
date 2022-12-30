import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/routes.dart';

class Common {
  var lang = Lang();
  var route = RouteHelper();
  String headline = '';

  Drawer drawer({String headline = ''}) {
    this.headline = headline;
    return Drawer(
      width: 180,
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(color: Colors.black38),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        height: 53,
                        width: 53,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            this.headline.substring(0, 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: ElevatedButton(
                      child: Text(
                        lang.personalSettings,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: Text(
              lang.managers,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () => print(lang.managers),
          )
        ],
      ),
    );
    ;
  }
}
