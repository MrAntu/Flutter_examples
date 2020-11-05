import 'package:flutter/material.dart';
import 'search_asset.dart';
class SearchBarDemo extends StatefulWidget {
  const SearchBarDemo({Key key}) : super(key: key);

  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBarDemo'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              }
          )
        ],
      ),
    );
  }
}


class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: Card(
          color: Colors.redAccent,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugges = query.isEmpty ? recentSuggest : searchList.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: sugges.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            query = sugges[index];
            showResults(context);
          },
          title: RichText(
            text: TextSpan(
              text: sugges[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: sugges[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ]
            ),
          ),

        )
    );
  }

}