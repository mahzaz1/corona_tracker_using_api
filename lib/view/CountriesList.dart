import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Services/Utilitis/statsServices.dart';
import 'CountryDetail.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  
  TextEditingController searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    StatsServices statsServices = StatsServices();


    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(width * .05),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: height * .015,horizontal: width * .03),
                hintText: 'Search Countries',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))
              ),
            ),
          Expanded(
            child: FutureBuilder(
              future: statsServices.fetchCountriesStatsRecord(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context,index){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(height: height * .01,width: double.infinity,color: Colors.white,),
                                leading: Container(height: height * .16,width: width * .16,color: Colors.white,),
                                subtitle: Container(height: height * .01,width: double.infinity,color: Colors.white,),
                              )
                            ],
                          ),
                        );
                      }
                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        String name = snapshot.data![index]['country'];
                        
                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              GestureDetector(
                                onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    CountryDetails(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  critical: snapshot.data![index]['critical'],
                                  totalRecoverd: snapshot.data![index]['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  casePerMillion: snapshot.data![index]['casesPerOneMillion'],
                                  testPerMillion: snapshot.data![index]['testsPerOneMillion'],
                                  deathsPerMillion: snapshot.data![index]['deathsPerOneMillion'],

                                )))  ;
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    height: height * 0.16,
                                    width: width * 0.16,
                                  ),
                                  subtitle: Text('Cases : ' + snapshot.data![index]['cases'].toString()),
                                  trailing: Text('${index + 1}'),
                                ),
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      CountryDetails(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['cases'],
                                        critical: snapshot.data![index]['critical'],
                                        totalRecoverd: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        casePerMillion: snapshot.data![index]['casesPerOneMillion'],
                                        testPerMillion: snapshot.data![index]['testsPerOneMillion'],
                                        deathsPerMillion: snapshot.data![index]['deathsPerOneMillion'],

                                      )))  ;
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    height: height * 0.16,
                                    width: width * 0.16,
                                  ),
                                  subtitle: Text('Cases : ' + snapshot.data![index]['cases'].toString()),
                                  trailing: Text('${index + 1}'),
                                ),
                              )
                            ],
                          );
                        }else{
                          
                        }
                        return Container();
                      }
                  );
                };
              },
            ),
          )


        ],
      ),
    );
  }
}
