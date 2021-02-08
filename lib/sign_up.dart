import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override

  String country;
  List countries = [
    "Johor", "Kedah", "Kelantan","Melaka","Negeri Sembilan","Pahang","Penang","Perak","Perlis","Sabah","Sarawak","Selangor","Terengganu"
  ];


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Create a new account"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'First name',
                      ),
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Last name'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.people_alt_rounded),
                    labelText: 'Username'),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email'),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password'),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Address line 1'),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Address line 2'),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text('Choose state'),
                value: country,
                onChanged: (newCountry){
                  setState(() {
                    country = newCountry;
                  });
                },
                items: countries.map((valueItems) {
                  return DropdownMenuItem(
                    value: valueItems,
                    child: Text(valueItems),
                  );
                }
                ).toList()
              ),
            ),

            SizedBox(height: 15,),

            Container(
              height: 45,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Post code'),
              ),
            ),

            SizedBox(height: 25,),

            Container(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Create my account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
