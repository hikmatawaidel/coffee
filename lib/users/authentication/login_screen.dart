import 'package:clothes_app/main.dart';
import 'package:clothes_app/users/authentication/signup_screen.dart';
import 'package:clothes_app/users/model/home_screen.dart';
import 'package:clothes_app/users/model/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// domain of your server
const String _baseURL = 'https://koki410.000webhostapp.com';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//used to perform various operations on the form, such as validation, resetting fields, or triggering form submission
  TextEditingController email = TextEditingController();// read and manipulate the text input by the user,
  TextEditingController pass = TextEditingController();// read and manipulate the text input by the user,
  var isObsecure = true.obs;//the .obs from GETX package making reactive boolean variable, enabling it to trigger updates in the UI whenever its value changes



  Future<void> login() async {
    try {
      var url = Uri.parse('$_baseURL/login.php');
      var response = await http.post(url, body: {
        'user_email': email.text,
        'user_password': pass.text,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Response body: ${response.body}');
        if (data["status"] == "Success") {
          // Login was successful
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.white,
            msg: 'Login Successful',
            toastLength: Toast.LENGTH_SHORT,
          );
          // Navigate to another screen after successful login
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (data == "Error") {
          // Login failed
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            textColor: Colors.white,
            msg: 'Login Failed',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        throw Exception('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Login Failed',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: LayoutBuilder(//It allows you to create responsive designs by adapting the layout according to the available space.
        builder: (context,cons){
          //It allows you to limit the size of a child widget within certain constraints, such as minimum and maximum width, height, or aspect ratio
          return ConstrainedBox(
            //defines constraints for a box layout in terms of its width, height, and their relationships
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,//for laying out the child widgets within the LayoutBuilder
            ),
            child: SingleChildScrollView(//create a scrollable view that contains a single child
              child: Column(
                children: [
                  //login screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                    height:285 ,
                    child: Image.asset("logo.png"),
                  ),
                  //login screen sign-in form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration:const BoxDecoration(
                        //the box of the login
                        color:Color(0xFF651E17),//background of the box
                        borderRadius: BorderRadius.all(Radius.circular(60)
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.brown,//the shadow of this box
                            offset: Offset(0,-3),

                          ),
                        ],
                      ),
                      child:Padding(
                        padding: const EdgeInsets.fromLTRB(30.0,30,30,8),//(left,top,right,bottom)
                        child: Column(
                          children: [
                            //email-password-login btn
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  //email
                                  TextFormField(
                                    controller: email,
                                    validator: (val) => val==""?"Please write email":null,//check if the user left it empty
                                    //define various visual elements such as labels, hint text, icons, borders, and more, enhancing the user experience of text input fields
                                    decoration: InputDecoration(
                                      //add an icon to the left side of a TextField
                                      prefixIcon:const Icon(Icons.email,color: Colors.black,
                                      ),
                                      //display a hint or placeholder text inside a TextField
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      //border around a TextField when it's in an enabled state but not focused
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      //the border around a TextField when it's in a focused state
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      //border around a TextField when it's in a disabled state
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      contentPadding:const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical:6,
                                      ),
                                      fillColor: Colors.white,//the box of the email
                                      filled: true,
                                    ),),
                                  const SizedBox(height: 18.0,),
                                  //password
                                  //reactive programming by automatically updating the UI whenever the observed variables change
                                  Obx(//the TextFeild may change during run time
                                        ()=>TextFormField(
                                      controller: pass,
                                      obscureText: isObsecure.value,//entered password hidden or not
                                      validator: (val) => val==""?"Please write password":null,
                                      decoration: InputDecoration(
                                        //icon on the left side
                                        prefixIcon:const Icon(Icons.vpn_key_sharp,color: Colors.black,
                                        ),
                                        //hiding and unhide the password on the right side
                                        suffixIcon:Obx(//reactive programming by automatically updating the UI whenever the observed variables change
                                              ()=>GestureDetector(
                                            onTap:(){
                                              //let the password be visible and hidden every time the user taps
                                              isObsecure.value=!isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value? Icons.visibility_off: Icons.visibility,
                                              color: Colors.black,
                                            ),),
                                        ),
                                        hintText: "Password..",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide:const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide:const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide:const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide:const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        contentPadding:const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical:6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),),
                                  ),
                                  const SizedBox(height: 18.0,),
                                  //button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    //wrap various widgets, making them interactive by responding to user taps or other gestures.
                                    child: InkWell(
                                      onTap: (){
                                        login();
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child:const Padding(
                                        padding:  EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text("Login",
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ) ,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16,),
                            //don't have an account btn-button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account."),
                                TextButton(onPressed:(){
                                  //when click on button send user to signup screen
                                  Get.to(SignUpScreen());
                                },
                                  child:const Text("Register Here",
                                    style: TextStyle(color:Colors.red,fontSize: 16 ),),),
                              ],
                            ),
                          ],
                        ),
                      ) ,
                    ),
                  ),
                  //
                ],
              ) ,
            ),
          );
        },
      ),
    );
  }
}
