import 'package:flutter/material.dart';

class TextFormFieldWedget extends StatelessWidget {
   TextFormFieldWedget({required this.textController,required this.Text,required this.errortext});
  TextEditingController textController;
  String Text;
  String errortext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return errortext;
                              }
                            },
                            
                            decoration: InputDecoration(
                                hintText: Text,
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(155, 242, 94, 61)),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffF25E3D)),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                labelStyle: TextStyle(color: Color(0xffF25E3D)),
                                prefixIconColor: Color(0xffF25E3D)),
                          );
  }
}
