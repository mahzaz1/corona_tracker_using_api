import 'package:corona_api/view/Home.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
   CountryDetails({Key? key,
        required this.name,
        required this.image,
        required this.critical,
        required this.casePerMillion,
        required this.deathsPerMillion,
        required this.testPerMillion,
        required this.totalCases,
        required this.totalDeaths,
        required this.totalRecoverd,
  }) : super(key: key);

  String name ,image;
  int totalCases, totalDeaths, totalRecoverd,critical,casePerMillion,testPerMillion,deathsPerMillion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .08,),
                      ReuseableRow(title: 'Total',value: totalCases.toString(),),
                      ReuseableRow(title: 'Critical',value: critical.toString(),),
                      ReuseableRow(title: 'Recovered',value: totalRecoverd.toString(),),
                      ReuseableRow(title: 'Deaths',value: totalDeaths.toString(),),
                      ReuseableRow(title: 'Case/Million',value: casePerMillion.toString(),),
                      ReuseableRow(title: 'Test/Million',value: testPerMillion.toString(),),
                      ReuseableRow(title: 'Deaths/Million',value: deathsPerMillion.toString(),),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image,),
              )
            ],
          )
        ],
      ),
    );
  }
}
