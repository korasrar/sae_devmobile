import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/API/endpoints.dart';
import 'package:mobile/UI/detail.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';



class home extends StatelessWidget {
  home({super.key});

  final api myApi = api();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myApi.getVols(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length??0,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 7,
                  margin: const EdgeInsets.all(10),
                    child:
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlue,
                          child: Text(snapshot.data?[index].num_vol.toString()??""
                          ),
                        ),
                        title: Text(snapshot.data?[index].date_depart??""),
                        subtitle: Text(
                            snapshot.data?[index].date_arrive.toString()??""),
                        trailing: IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.blue),
                          onPressed: () {
                            context.read<MyVolsViewModel>().addVol(snapshot.data![index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Vol ajouté aux favoris')),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => Detail(vol: snapshot.data![index]),
                            ),
                          );
                        },
                      )
                );
              },
            );
          }else{
            return const Center(
              child: Text("Aucune donnée trouvée"),
            );
          }
        }
    );
  }
}

