import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Statefull Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.tealAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();

  var _currencies = ['KSH', 'USD', "EUROS", "Others"];
  final _minimumPadding = 5.0;

  var _currentItemSelected = " ";

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  var displayResult = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Simple Interest Calculator",
//            style: TextStyle(
//              color: Colors.white
//            ),
        ),
      ),
      body: Form(
        key: _formkey,
        //margin: EdgeInsets.all(_minimumPadding * 2),
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  //style: textStyle,
                  controller: principalController,
                  validator: (String value) {
                    if (value.isEmpty){
                      return "Please enter principal amount";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter Principal e.g 12000",
                      //labelStyle: textStyle,
//                      errorStyle: TextStyle(
//                        color: Colors.orange
//                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                    //style: textStyle,
                    controller: roiController,
                    // ignore: missing_return
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please enter rate of interest";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "In percent",
                        //labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                          //style: textStyle,
                          controller: termController,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter term";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Term",
                              hintText: "In years",
                              //labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)))),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          //Code for when a menu item is selected from a dropdown
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding * 5, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if(_formkey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          }),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          child: Text("Reset", textScaleFactor: 1.5),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding * 3, bottom: _minimumPadding * 3),
                  child: Text(
                    displayResult, /*style: textStyle,*/
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/bankIcon.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    //Simple interest formula
    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        "After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = " ";
    roiController.text = " ";
    termController.text = " ";
    displayResult = " ";
    _currentItemSelected = _currencies[0];
  }
}
