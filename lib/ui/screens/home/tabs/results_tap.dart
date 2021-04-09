import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var dbService =
                  RepositoryProvider.of<LocalDatabaseService>(context);
              await dbService.openDatabase();

              print(await dbService.queryTable("RESULT"));
              await dbService.insert("RESULT", {"NAME": "Daniel"});
              print(await dbService.queryTable("RESULT"));
            },
            child: Text("Database"),
          ),
        ],
      ),
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Results";
}
