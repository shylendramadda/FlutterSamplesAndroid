import 'package:FlutterSamples/samplepreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class WidgetsScreen extends StatefulWidget {
  @override
  WidgetsState createState() => WidgetsState();
}

class WidgetsState extends State<WidgetsScreen> {
  List<Sample> widgetEntries = List();
  List<Sample> filteredList = List();
  TextEditingController searchWidgetController = TextEditingController();
  String searchText = "";
  bool isShowSearch = false;

  @override
  void dispose() {
    searchWidgetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var widgetsList = buildWidgetEntries();
    filteredList = widgetsList;
    searchWidgetController.addListener(textListener);
    super.initState();
  }

  void textListener() {
    searchText = searchWidgetController.text;
  }

  filterData(String input) {
    setState(() {
      filteredList = widgetEntries
          .where((element) => (element.title
              .toLowerCase()
              .contains(input.trim().toLowerCase())))
          .toList();
    });
  }

  resetData() {
    setState(() {
      searchWidgetController.text = "";
      isShowSearch = !isShowSearch;
      filteredList = widgetEntries;
    });
  }

  onTapListItem(int index, BuildContext context) {
    if (isShowSearch) {
      resetData();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SamplePreviewScreen(sample: filteredList[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Visibility(
            visible: isShowSearch,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    Flexible(
                        child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                                labelText: 'Search for widget...'),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            controller: searchWidgetController,
                            onChanged: (input) => filterData(input))),
                    IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (searchText.isNotEmpty) {
                              searchWidgetController.text = "";
                              filteredList = widgetEntries;
                            } else {
                              isShowSearch = false;
                            }
                          });
                        }),
                  ],
                ))),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Text('${filteredList[index].title}'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => onTapListItem(index, context),
                  ));
                }))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resetData();
        },
        tooltip: 'Search Widgets',
        child: Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }

  List<Sample> buildWidgetEntries() {
    widgetEntries.add(Sample(15, "Text", """

import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Text Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Simple Text"),
              Text(
                "This is a overflow text. It will show ellipsis at the end when the text reaches at the end of the screen.",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
              ),
              RichText(
                text: TextSpan(
                  text: 'Rich Text',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' bold',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' world!'),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Text.rich text', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: ' beautiful ',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    TextSpan(
                        text: 'world',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text(
                'It is a strikethrough text',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              Text(
                'It is a underlined text',
                style: TextStyle(decoration: TextDecoration.underline),
              )
            ],
          ),
        ));
  }
}

    """));
    widgetEntries.add(Sample(11, "Button", """
    
    import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Button Demo"),
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      child: Text('Flat Button',
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                      onPressed: () {}),
                  SizedBox(height: 20), // for add space
                  IconButton(
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.red,
                        size: 36,
                      ),
                      tooltip: 'Image Button',
                      onPressed: () {}),
                  SizedBox(height: 20),
                  RaisedButton(
                    child:
                        Text('Disabled Button', style: TextStyle(fontSize: 20)),
                    onPressed: null,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                      child: const Text('Enabled Button',
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {}),
                  SizedBox(height: 20),
                  RaisedButton(
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Gradient Button',
                            style: TextStyle(fontSize: 20)),
                      ),
                      onPressed: () {}),
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                      label: Text('Floating Action Button'),
                      icon: Icon(Icons.thumb_up),
                      backgroundColor: Colors.blue,
                      onPressed: () {}),
                  SizedBox(height: 20),
                  OutlineButton(
                      child: new Text("Outline Button"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {})
                ],
              ),
            ),
          ],
        ));
  }
}

    """));
    widgetEntries.add(Sample(12, "Dropdown", """
    
    import 'package:flutter/material.dart';

class DropDownScreen extends StatefulWidget {
  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDownScreen> {
  var dropdownValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dropdown Button"),
        ),
        body: Center(
            child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple, fontSize: 12),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['One', 'Two', 'Three', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
  }
}

    """));
    widgetEntries.add(Sample(13, "Popup Menu", """
    
    import 'package:flutter/material.dart';

class PopupMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Popup Menu Demo"),
        ),
        body: Center(
            child: PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("First"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("Second"),
            ),
            PopupMenuItem(
              value: 3,
              child: Text("Third"),
            ),
          ],
          initialValue: 1,
          onCanceled: () {
            showSnackBar(context, 'You have canceled the menu.');
          },
          onSelected: (value) {
            showSnackBar(context, 'You have selected the value.');
          },
          icon: Icon(Icons.list),
        )));
  }

  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1000),
    ));
  }
}

    """));
    widgetEntries.add(Sample(14, "Snack Bar", """

import 'package:flutter/material.dart';

class SnackBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SnackBar Demo"),
        ),
        body: Center(
          child: RaisedButton(
              child: Text('Show SnackBar', style: TextStyle(fontSize: 20)),
              color: Colors.amberAccent,
              onPressed: () {
                showSnackBar(
                    context, "This is a snack bar message with icon", 2000);
              }),
        ));
  }

  void showSnackBar(BuildContext context, String message, int duration) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.favorite_border, color: Colors.deepOrange),
          Text(
            message,
            style: TextStyle(color: Colors.amber),
          )
        ],
      ),
      duration: Duration(milliseconds: duration),
    ));
  }
}

    """));
    widgetEntries.add(Sample(16, "Checkbox", """

import 'package:flutter/material.dart';

class CheckBoxScreen extends StatefulWidget {
  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBoxScreen> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Checkbox Demo")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    checkbox("Monday", monVal),
                    checkbox("Tuesday", tuVal),
                    checkbox("Wednesday", wedVal),
                    checkbox("Thursday", thurVal),
                    checkbox("Friday", friVal),
                    checkbox("Saturday", satVal),
                    checkbox("Sunday", sunVal),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "Monday":
                  monVal = value;
                  break;
                case "Tuesday":
                  tuVal = value;
                  break;
                case "Wednesday":
                  wedVal = value;
                  break;
                case "Thursday":
                  thurVal = value;
                  break;
                case "Friday":
                  friVal = value;
                  break;
                case "Saturday":
                  satVal = value;
                  break;
                case "Sunday":
                  sunVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }
}

    """));
    widgetEntries.add(Sample(17, "Row", """

import 'package:flutter/material.dart';

class RowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Row Demo')),
      body: Center(
          child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.blue[50],
            child: Text('Item1', textAlign: TextAlign.center),
          )),
          Expanded(
              child: Container(
            color: Colors.red[50],
            child: Text('Item2', textAlign: TextAlign.center),
          )),
          Expanded(
            child: Container(
                color: Colors.green[50],
                child: FittedBox(
                  fit: BoxFit.contain, // otherwise the logo will be tiny
                  child: const FlutterLogo(),
                )),
          ),
        ],
      )),
    );
  }
}

    """));
    widgetEntries.add(Sample(18, "Column", """

import 'package:flutter/material.dart';

class ColumnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Column Demo')),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.blue[50],
            child: Text('Item1', textAlign: TextAlign.center),
          )),
          Expanded(
              child: Container(
            color: Colors.red[50],
            child: Text('Item2', textAlign: TextAlign.center),
          )),
          Expanded(
            child: Container(
                color: Colors.green[50],
                child: FittedBox(
                  fit: BoxFit.contain, // otherwise the logo will be tiny
                  child: const FlutterLogo(),
                )),
          ),
        ],
      )),
    );
  }
}

    """));
    widgetEntries.add(Sample(19, "Stack", """

import 'package:flutter/material.dart';

class StackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo')),
      body: Stack(
        children: <Widget>[
          Container(
            width: 400,
            height: 400,
            color: Colors.amberAccent,
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.pink,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.green,
          ),
          Container(
            width: 20,
            height: 20,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

    """));
    widgetEntries.add(Sample(20, "Container", """

import 'package:flutter/material.dart';

class ContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Demo'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.amber[600],
          width: 80.0,
          height: 80.0,
        ),
      ),
    );
  }
}

    """));
    widgetEntries.add(Sample(21, "MaterialApp", """

import 'package:flutter/material.dart';

class MaterialAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MaterialApp Demo'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('This is a sample text to display in a material app'
                'The text can wrap based on the screen width'
                'This is implemented by using Material app.'),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

    """));
    return widgetEntries;
  }
}
