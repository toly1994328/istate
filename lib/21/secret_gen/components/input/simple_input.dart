import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final String info;
  final double radius;

  const SimpleInput(
      {Key? key,
        this.controller,
        required this.label,
        required this.hint,
        required this.info,
        this.keyboardType,
        this.radius = 12,
      })
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if(label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: SizedBox(
            height: 40,
            child: TextField(
              onTapOutside: (v){
                final FocusScopeNode focusScope = FocusScope.of(context);
                if (focusScope.hasFocus) {
                  focusScope.unfocus();
                }
              },

              style: TextStyle(fontSize: 14),
              controller: controller,
              obscureText: false,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(top: 2, left: 15),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                  ),
                  filled: true,
                  fillColor: Colors.white
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            info,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}