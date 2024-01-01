import 'package:clothes_app/users/model/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clothes_app/users/authentication/login_screen.dart';

// domain of your server
const String _baseURL = 'https://koki410.000webhostapp.com';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//used to perform various operations on the form, such as validation, resetting fields, or triggering form submission
  TextEditingController name = TextEditingController();// read and manipulate the text input by the user
  TextEditingController email = TextEditingController();// read and manipulate the text input by the user
  TextEditingController pass = TextEditingController();// read and manipulate the text input by the user
  var isObsecure = true.obs;//the .obs from GETX package making reactive boolean variable, enabling it to trigger updates in the UI whenever its value changes

  Future<void> register() async {
    try {
      var url = Uri.parse('$_baseURL/signup.php');
      var response = await http.post(url, body:{
        'user-name': name.text,
        'user_email': email.text,
        'user_password': pass.text,
      });

      if (response.statusCode == 200) {
        // Assuming the server returns a JSON response
        var data = json.decode(response.body);

        // Check the data returned by the server and handle accordingly
        if (data != null && data is String) {
          if (data == "Success") {
            // Registration was successful
            Fluttertoast.showToast(
              backgroundColor: Colors.green,
              textColor: Colors.white,
              msg: 'Registration Successful',
              toastLength: Toast.LENGTH_SHORT,
            );

            // Navigate to another screen after successful registration
            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
          } else if (data == "Error") {
            // User already exists
            Fluttertoast.showToast(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              msg: 'User already exists',
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        } else {
          // Handle unexpected response format
          throw Exception('Unexpected response format');
        }
      } else {
        // Handle non-200 status codes
        throw Exception('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions or errors
      print('Error occurred: $e');
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Error occurred: $e',
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
                //signup screen header
                children: [

                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                    height:285 ,
                    child: Image.asset("assets/logo.png"),
                  ),
                  //signup screen sign-up form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration:const BoxDecoration(
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
                                  //name
                                  TextFormField(
                                    controller: name,
                                    validator: (val) => val==""?"Please write name":null,//check if the user left it empty
                                    //define various visual elements such as labels, hint text, icons, borders, and more, enhancing the user experience of text input fields
                                    decoration: InputDecoration(
                                      //add an icon to the left side of a TextField
                                      prefixIcon:const Icon(Icons.person,color: Colors.black,
                                      ),
                                      //display a hint or placeholder text inside a TextField
                                      hintText: "Name",
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
                                  //email
                                  TextFormField(
                                    controller: email,
                                    validator: (val) => val==""?"Please write email":null,
                                    decoration: InputDecoration(

                                      prefixIcon:const Icon(Icons.email,color: Colors.black,
                                      ),
                                      hintText: "Email",
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
                                        if(_formKey.currentState!.validate()){//if the user provided email username and password
                                          //validate the email
                                          register();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child:const Padding(
                                        padding:  EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text("SignUp",
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
                            //don't have an account btn-button
                            const SizedBox(height: 16,),
                            //already have an account
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account."),
                                TextButton(onPressed:(){
                                  //when click on button send user to login screen
                                  Get.to(LoginScreen());
                                },
                                  child:const Text("Login Here",
                                    style: TextStyle(color:Colors.red ),),),
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