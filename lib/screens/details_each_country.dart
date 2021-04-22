import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:covid19/component/box_report.dart';
import 'package:covid19/ui/constant.dart';
import 'package:animator/animator.dart';
import 'dart:math';

class DetailsEachCountry extends StatefulWidget {
 final Map country;
 DetailsEachCountry({this.country});

  @override
  _DetailsEachCountryState createState() => _DetailsEachCountryState();
}

class _DetailsEachCountryState extends State<DetailsEachCountry> {
  var selectedcountry;
  bool loading = true;
  List countries = new List();
  List items = new List();
  var toDate;
  var yesterday;
  DateTime date=DateTime.now();
  var from;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setData();
    toDate = DateTime.now().toString().split(' ')[0];
    from = DateTime(date.year,date.month -1,date.day).toString().split(' ')[0];
   yesterday = DateTime(date.year,date.month,date.day -1).toString().split(' ')[0];
     print(widget.country);
     print('date is :$toDate');
     print('date is :$from');
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: _bodySelectedCountry(),
    );
  }
 void _setData() async {
   toDate = DateTime.now().toString().split(' ')[0];
   var url = 'https://api.covid19api.com/country/${widget.country['Slug']}?from=2020-10-23T00:00:00Z&to=${toDate}T00:00:00Z';
   var response = await http.get(url);
   if (response.statusCode == 200) {
     var jsonResponse = convert.jsonDecode(response.body);
     countries = jsonResponse;
     items.addAll(jsonResponse);
     print(url);
     print('list of data:$items');
     setState(() {
       loading = false;
     });
   } else {

   }
 }

  Widget _bodySelectedCountry() {
    if(loading) {
      return SpinKitWave(
          color:mainColor, type: SpinKitWaveType.center);
    }
    return Column(
      children: [
         Expanded(
           child: ListView.builder(
             padding: EdgeInsets.zero,
             shrinkWrap: false,
              itemCount: items.length,
              itemBuilder: (BuildContext context,int index){
                var country=items[index];
                if(index==0){
                  return Container();
                }
                var deathday;
                var confirmedday;
                var recoverdday;
                var activeday;
                deathday = (country['Deaths']-items[index-1]['Deaths']).toString();
                confirmedday = (country['Confirmed']-items[index-1]['Confirmed']).toString();
                recoverdday = (country['Recovered']-items[index-1]['Recovered']).toString();
                activeday = (country['Active']-items[index-1]['Active']).toString();

                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image:  DecorationImage(
                              image: AssetImage(
                                  'assets/coronapic/background.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 75,
                          left: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25,),
                              Text('${country['Country']}',style:TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:Color(0xffffffff),
                              ),),
                              SizedBox(height: 5,),
                              Text('$toDate',style:TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color:Color(0xffffffff),
                              ),),
                            ],
                          )
                      ),
                      Positioned(
                        top: 260,
                        left: 25,
                        right: 25,
                        child: Container(
                          height: 110,
                          width:300,
                          decoration: BoxDecoration(
                              color:backBox,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(1,1),
                                  blurRadius: 5,
                                  color:Colors.black38,
                                )
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Today Report',

                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:Color(0xff003d64),
                                      ),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Confirmed',
                                      style: TodayStyleTitle,),
                                    Text('Deaths',
                                        style: TodayStyleTitle),
                                    Text('Recoverded', style: TodayStyleTitle),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('$confirmedday',
                                      style: TodayStyleRes,),
                                    Text('$deathday',
                                        style: TodayStyleRes),
                                    Text('$recoverdday',
                                        style: TodayStyleRes),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 28,
                        left: 15,
                        child: Container(
                          child: Animator(
                            tween: Tween<double>(begin: 0, end: 2* pi),
                            duration: Duration(seconds: 6),
                            repeats: 0,
                            builder: (_,AnimatorState,__)=>Transform.rotate(
                              angle:AnimatorState.value,
                              child: Image.asset('assets/coronapic/virus2.png',height: 60,width: 60,),
                            ),

                          ),
                        ),
                      ),
                      Positioned(
                          top: 380,
                          bottom: 10,
                          left: 18,
                          right: 18,
                        child:Container(
                          child: Column(

                            children: [
                              Text('Total statistics',style: titlestatc,),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BoxesReport(
                                        TitleName: Text('Confirmed',
                                        style: TitleBoxes),
                                        Total: Text('${country['Confirmed'].toString()}',
                                          style: resultBox),
                                      ),
                                    ),
                                    Expanded(
                                      child: BoxesReport(
                                        TitleName: Text('Recovered',
                                            style: TitleBoxes),
                                        Total: Text('${country['Recovered']}',
                                            style: resultBox),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BoxesReport(
                                        TitleName: Text('Active',
                                            style: TitleBoxes),
                                        Total: Text('${country['Active']}',
                                            style: resultBox),
                                      ),
                                    ),
                                    Expanded(
                                      child: BoxesReport(
                                        TitleName: Text('Deaths',
                                            style: TitleBoxes),
                                        Total: Text('${country['Deaths']}',
                                            style: resultBox),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
         )
      ],
    );
  }
}
