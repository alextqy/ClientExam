import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/routes.dart';

class Common {
  var lang = Lang();
  var route = RouteHelper();

  Drawer drawer() {
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
                  const SizedBox(
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
                            'R',
                            style: TextStyle(
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
                      onPressed: () {
                        print('fuck');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              '设置',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
    ;
  }
}
