import 'package:flutter/material.dart';
import 'package:history_feature/screens/job_operations_screen.dart';
import 'package:history_feature/widgets/jobs_list.dart';
import 'package:provider/provider.dart';

import '../providers/jobs.dart';
import '../widgets/main_drawer.dart';

class JobView extends StatelessWidget {
  JobView({Key? key, this.history = false}) : super(key: key);
  static const routeNameForView = '/home';
  static const routeNameForHistory = '/history';
  final bool history;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      //drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          if (history && Provider.of<Jobs>(context, listen: false).userType != "Applicant")
            IconButton(
              icon: Icon(Icons.add),
              color: Theme.of(context).bottomAppBarColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return JobOperations();
                }));
              },
            )
        ],
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 0),
            child: Text(
              history ? 'History' : 'Jobs',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Container(
          height: 40.0,
          child: TextField(
            decoration: InputDecoration(
              // constraints: BoxConstraints(
              //   minHeight: 40.0,
              //   maxHeight: 40.0,
              // ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
        leadingWidth: 80.0,
      ),
      body: FutureBuilder(
        future: !history
            ? Provider.of<Jobs>(context, listen: false).fetchAndSetJobs()
            : Provider.of<Jobs>(context, listen: false).userType == "Applicant"
                ? Provider.of<Jobs>(context, listen: false)
                    .fetchAndSetHistoryJobsOfApplicant()
                : Provider.of<Jobs>(context, listen: false)
                    .fetchAndSetJobsOfRecruiter(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Jobs>(
                builder: (_, cart, ch) => JobsList(
                  history: history,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
