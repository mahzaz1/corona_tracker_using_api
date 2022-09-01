import 'package:corona_api/Model/WorldStatsModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/Utilitis/statsServices.dart';
import 'CountriesList.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: height * .05,),
            FutureBuilder(
              future: statsServices.fetchWorldStatsRecord(),
                builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                      child: SpinKitPouringHourGlassRefined(
                          color: Colors.green,
                        size: 50,
                        controller: _controller,
                      )
                  );
                }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(snapshot.data!.recovered.toString()),
                            'Death': double.parse(snapshot.data!.deaths.toString()),
                          },
                          colorList: [
                            Colors.blue,
                            Colors.green,
                            Colors.red
                          ],
                          chartType: ChartType.ring,
                          chartRadius: width * .3,
                          animationDuration: Duration(seconds: 2),
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(vertical:height * .06 ),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                                ReuseableRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                                ReuseableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                                ReuseableRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                                ReuseableRow(title: 'Case/Million',value: snapshot.data!.casesPerOneMillion.toString(),),
                                ReuseableRow(title: 'Test/Million',value: snapshot.data!.testsPerOneMillion.toString(),),
                                ReuseableRow(title: 'Deaths/Million',value: snapshot.data!.deathsPerOneMillion.toString(),),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                          },
                          child: Container(
                            height: height * .06,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text('Track Countries'),),
                          ),
                        )
                      ],
                    );
                  }
                }
            ),


          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
   ReuseableRow({Key? key,required this.value,required this.title}) : super(key: key);

   String title,value;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),

        ],
      ),
    );
  }
}
