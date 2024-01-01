import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 100,bottom: 40),
        decoration: BoxDecoration(
          color: Color(0xFFBCAAA4),
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            opacity: 0.45,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Coffee Shop", style: GoogleFonts.pacifico(
                fontSize: 50,color: Colors.white
            ),

            ),
            Column(children: [
              Material(
                color: Color(0xFF651E17),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 50),
                    child: const Text("Get Started",style:TextStyle(color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),),
                  ),
                ),
              ),

              SizedBox(height:60 ,),
              Text("Feeling Low? Take a Sip of Coffee",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),

              ),
            ],)

          ],
        ),
      ),
    );

  }
}


