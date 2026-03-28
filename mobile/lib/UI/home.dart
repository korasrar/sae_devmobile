import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/API/endpoints.dart';
import 'package:mobile/UI/detail.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final api myApi = api();
  final SearchController controller = SearchController();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
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
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                          color: Colors.white,
                          elevation: 7,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Text(snapshot.data?[index].num_vol.toString() ?? ""),
                            ),
                            title: Text(snapshot.data?[index].date_depart ?? ""),
                            subtitle: Text(snapshot.data?[index].date_arrive.toString() ?? ""),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_circle, color: Colors.blue),
                              onPressed: () async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      content: Stack(
                                          clipBehavior: Clip.none,
                                          children: <Widget>[
                                            Positioned(
                                              right: -40,
                                              top: -40,
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.close),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                  child: const Text("Vol Personnel"),
                                                  onPressed: () {
                                                    Vol vol = snapshot.data![index];
                                                    vol.isPro = false;
                                                    context.read<MyVolsViewModel>().addVol(vol);
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text('Vol ajouté aux favoris')),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  child: const Text("Vol Professionnel"),
                                                  onPressed: () {
                                                    Vol vol = snapshot.data![index];
                                                    vol.isPro = true;
                                                    context.read<MyVolsViewModel>().addVol(vol);
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text('Vol ajouté aux favoris')),
                                                    );
                                                  },
                                                )
                                              ],
                                            )
                                          ])),
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
                          ));
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Aucune donnée trouvée"),
                  );
                }
              }),
        ),
      ],
    );
  }
}
