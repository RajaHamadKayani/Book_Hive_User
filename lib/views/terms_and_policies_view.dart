import 'package:flutter/material.dart';

class TermsAndPoliciesView extends StatefulWidget {
  const TermsAndPoliciesView({super.key});

  @override
  State<TermsAndPoliciesView> createState() => _TermsAndPoliciesViewState();
}

class _TermsAndPoliciesViewState extends State<TermsAndPoliciesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AGREEMENT",
          style: TextStyle(
            color: Color(0xff9F9F9F),
            fontSize: 16,
            fontWeight: FontWeight.w300,
            fontFamily: "Pulp"
          ),),
          const SizedBox(height: 6,),
          Text("Terms and Policies",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: "Pulp"
          ),),
          Text("Last updated on 4/5/2024"),
          const SizedBox(height: 22,),
          Text("Clause 1",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Pulp"
          ),),
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "Pulp"
          ),),
            const SizedBox(height: 22,),
          Text("Clause 2",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Pulp"
          ),),
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "Pulp"
          ),),
          const SizedBox(height: 50,),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "Pulp"
          ),),
          const SizedBox(height: 40,),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: Color(0xff168FFF),
                borderRadius: BorderRadius.circular(100)
              ),
              child: Padding(padding: EdgeInsets.symmetric(
                vertical: 15
              ),
              child: Center(
                child: Text("Accept & Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Pulp"
                ),),
              ),),
            ),
          )
        ],
      ),)),
    );
  }
}