import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/resgister_page.dart';
import 'package:scholar_chat/widgets/constant.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);
static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  late String email;
  late String password;

  GlobalKey<FormState>formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(

      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
               SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar Chat',
                    style: TextStyle(
                      fontSize:32 ,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),),
                  ],
                ),
                SizedBox(height: 75,),
                Row(
                  children: [
                    Text('LOGIN',
                    style: TextStyle(
                      fontSize:24 ,
                      color: Colors.white,

                    ),),
                  ],
                ),
                 SizedBox(
                   height: 10,
                 ),
                 CustomFormTextField(

                   onChanged: (data){
                     email = data;
                   },
                   hintText: 'Email',
                 ),
                SizedBox(
                  height: 10,
                ),
                 CustomFormTextField(
                   obscureText: true,
                   onChanged: (data){
                     password = data;
                   },
                   hintText: 'Password',
                 ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: ()
                  async
                  {
                    if(formKey.currentState!.validate())
                    {
                      isLoading = true;
                      setState(() {
                      });
                    try {
                    await loginUser();
                    Navigator.pushNamed(context, ChatPage.id ,arguments: email);
                    }
                    on FirebaseAuthException catch (ex) {
                    if (ex.code == 'user-not-found') {
                    showSnackBar(context, 'user- not-found');
                    } else if (ex.code == 'wrong password') {
                    showSnackBar(context, 'wrong password');
                    }
                    } catch (ex) {
                    showSnackBar(context, 'there was an error');
                    }
                    isLoading = false;
                    // to update the ui
                    setState(() {

                    });
                    }else{}

                  },

                  text: 'LOGIN',),
                SizedBox(
                  height: 10,
                ),
                Row  (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                            ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                          '  Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                              ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),

      ),
    );
  }


  Future<void> loginUser()  async {
    UserCredential user =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password);

  }

}
