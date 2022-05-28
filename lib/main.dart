import 'package:flutter/material.dart';
import 'package:shopify_admin_graphql/email_login.dart';
import 'package:shopify_admin_graphql/shop_list.dart';


void main(){
  runApp( MaterialApp(debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const EmailLogin()),
              );
            }, child: const Text("Login Via Email and password")),
            ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ShopList()),
                );
              },
              child: const Text("Login via access token"),
            ),
          ],
        ),
      )
    );
  }
}
