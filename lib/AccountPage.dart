import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify/theme/change_theme_button_widget.dart';



class Account extends StatefulWidget {
   Account({super.key});



  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  
 var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Container(
              width: screenWidth*5/6,
              height: screenHeight*2/3,
              decoration: BoxDecoration(
                color:  Color.fromARGB(55, 185, 184, 184),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Column(
                    
                    children: [ 
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        radius: 50,
                        backgroundImage: AssetImage("assets/man.png"),
                      
                      ),
                      SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your Name: ",style: TextStyle(fontSize: 26),),
                      SizedBox(width: 10,),
                      Text(user!.displayName!,style: TextStyle(fontSize: 23),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dark Mode: ",style: TextStyle(fontSize: 26),),
                      SizedBox(width: 10,),
                      ChangeThemeButtonWidget(),
                    ],
                  ),
                  SizedBox(height: 30,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon( // <-- Icon
                                    Icons.settings,
                                    size: 24.0,
                                  ),
                                  label: Text('Setting'), // <-- Text
                                ),
                    ],
                  ),
          
                  SizedBox(height: 30,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon( // <-- Icon
                                    Icons.language,
                                    size: 24.0,
                                  ),
                                  label: Text('Language'), // <-- Text
                                ),
                    ],
                  ),
          
                  
                  ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

