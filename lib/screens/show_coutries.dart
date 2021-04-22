import 'package:covid19/ui/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'details_each_country.dart';
//import 'package:covid19/screens/details_each_country.dart';


class ShowCountries extends StatefulWidget {
  @override
  _ShowCountriesState createState() => _ShowCountriesState();
}

class _ShowCountriesState extends State<ShowCountries> {

  List countries = new List();
  List items = new List();
  bool loading = true;
  bool isSelected=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
        return [
          SliverAppBar(

            title: Center(child: Text('All Countries'),
            ),
            backgroundColor:mainColor,
          )
        ];
      }, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    if(loading) {
      return SpinKitWave(
          color:mainColor, type: SpinKitWaveType.center);
    }
    return new Container(
      child: new Column(
        children: [
          new Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.go,
              onChanged: (String value){
                items.clear();
                if(value.isEmpty){
                  items.clear();
                  items.addAll(countries);
                }else{
                  countries.forEach((element) {
                    if(element['Country'].toString().toLowerCase().contains(value.toLowerCase())){
                      items.add(element);
                    }
                  });
                }
                setState(() {

                });

              },
              cursorColor:mainColor,
              decoration: InputDecoration(
                labelText: 'Search',
                // hintText: 'Serach',
                labelStyle:TextStyle(
                    color: mainColor,
                ),
                prefixIcon: Icon(Icons.search,
                  color:mainColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: mainColor,
                      width:2
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hoverColor:mainColor,
              ),
            ),
          ),
          new Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder:(BuildContext contex,int index){
                  var country = items[index];
                  print(country);
                  return Padding(
                    padding: const EdgeInsets.only(top:3.0),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        selectedTileColor: !isSelected?mainColor:backBox,
                        hoverColor: isSelected?mainColor:backBox,
                        onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder:(context){
                       return DetailsEachCountry(country: country,);
                     }
                     ));
                        setState(() {
                          isSelected =!isSelected;
                        });
                        },
                        title: Text('${country['Country']}'),
                        subtitle:  Text('${country['Slug']}'),
                        trailing: Image.asset('assets/flagcountries/${country['ISO2'].toLowerCase()}.png',
                          width: 60,
                        ),
                      ),
                    ),
                  );
                } ),
          )
        ],
      ),
    );
  }

  void _setData() async {
    var url = 'https://api.covid19api.com/countries';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      countries = jsonResponse;
      items.addAll(jsonResponse);
      setState(() {
        loading = false;
      });
    } else {

    }
  }
}