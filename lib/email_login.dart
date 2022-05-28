import 'package:flutter/material.dart';
import 'package:shopify_admin_graphql/shop_list.dart';
import 'package:shopify_admin_graphql/store_products.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email"
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "password"
              ),
            ),

            ElevatedButton(onPressed: (){
              String email = emailController.text;
              String password = "rR#WU-TJnAhR52g";

              if(email.isEmpty||password.isEmpty){
                const snackBar = SnackBar(
                    content: Text("One of these fields is empty"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                checkCreds(email,password);

              }
            }, child: const Text("Login")),

            const Text("Password is hardcoded, enter anything")
          ],
        ),
      ),
    );
  }

  void checkCreds(String email, String password) {
    if(email!="khkrlife@gmail.com"){
      const snackBar = SnackBar(
          content: Text("Incorrect email"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if(password!="rR#WU-TJnAhR52g") {
      const snackBar = SnackBar(
          content: Text("Incorrect password"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShopList()),
    );
  }
}
