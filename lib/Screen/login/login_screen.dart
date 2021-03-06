import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:loja_virtual/helpers/validators.dart';

import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/models/user/user_manager.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {

                  if(userManager.loadingFace){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'E-mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) return 'E-mail inválido';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty || pass.length < 6)
                            return 'Senha inválida';
                          return null;
                        },
                      ),
                      child,
                      const SizedBox(
                        height: 16,
                      ),
                      RaisedButton(
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        onPressed: userManager.loading ? null : () {
                                if (formkey.currentState.validate()) {
                                  userManager.signIn(
                                      user: User(
                                          email: emailController.text,
                                          password: passController.text
                                     ),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar( 
                                              content:  Text('Falha ao Entrar '),
                                              backgroundColor: Colors.red,
                                            ),
                                        );
                                      },
                                      onSucess: () {
                                        Navigator.of(context).pop();
                                    }
                                  );
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                        text: 'Entrar com Facebook',
                        onPressed: (){
                          userManager.facebookLogin(
                          onFail: (e) {
                            
                          ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar( 
                                  content:  Text('Falha ao Entrar'),
                                  backgroundColor: Colors.red,
                                  ),
                            );
                          },
                       
                           onSuccess: (){
                            Navigator.of(context).pop();
                           }
                          );
                        }
                      )
                    ]
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Text('Esqueci minha senha'),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
