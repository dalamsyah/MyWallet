
import 'package:flutter/material.dart';
import 'package:my_budgets/models/m_models.dart';
import 'package:my_budgets/repo/view_model.dart';

class CategoriesPage extends StatefulWidget {
  static String tag = 'categories-page';
  @override
  State<StatefulWidget> createState() => _CategoriesPage();

}

class _CategoriesPage extends State<CategoriesPage> {

  final Future<List<CategoryModel>> categories = ViewModelCashFlow().fetchCategory();

  Widget monumentList( List<CategoryModel> monumentList) {
    return ListView.builder(
        itemCount: monumentList.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "|| " + monumentList[index].category_name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    // Container(
                    //   child: Image.network(monumentList[index].imageUrl),
                    // ),
                    Container(
                      child: Text(
                        '\n' + monumentList[index].type_category!,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder<List<CategoryModel>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? monumentList(snapshot.data!)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

}