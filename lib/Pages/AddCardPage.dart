import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_accounting/Components/AppBarComponent.dart';
import 'package:flutter_accounting/Database/moor_database.dart';
import 'package:flutter_accounting/Models/CardModel.dart';
import 'package:flutter_accounting/Styles/MainStyles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_accounting/Providers/CardProvider.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController bankController = new TextEditingController();
  TextEditingController availableController = new TextEditingController();
  TextEditingController currencyController = new TextEditingController();

  void onAdd() {
    final CardModel card = CardModel(color: Colors.blue, name: nameController.text, number: numberController.text, bank: bankController.text, available: num.tryParse(availableController.text), currency: currencyController.text);
    Provider.of<CardProvider>(context).addCard(card);
    final database = Provider.of<AppDatabase>(context);

    BankCard bankCard = BankCard(name: nameController.text, number: numberController.text, bank: bankController.text, available: num.tryParse(availableController.text), currency: currencyController.text);
    database.insertCard(bankCard);
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainStyles.bodyColor,
      appBar: AppBarComponent.getAppBar("Add new card", 
        IconButton(
          icon: new Icon(Icons.arrow_back, color: MainStyles.brandGray, size: 25,), 
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ), Icon(null)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.title),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Card name'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.credit_card),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Card number'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: bankController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_balance),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Bank name'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: availableController,
                    inputFormatters: <TextInputFormatter>[
                      // WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.attach_money),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Available Balance'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: currencyController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.flag),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Currency'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: MainStyles.primaryColor,
                  child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                  onPressed: () => onAdd()
                ),
                Container(
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
