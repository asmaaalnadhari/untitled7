
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'dart:developer';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectField with Search Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Directionality(
        textDirection: TextDirection.rtl,
        child: AnimatedExpansionTile(),
      ),
    );
  }
}


class Service  with CustomDropdownListFilter{
  final int id;
  final String name;
  final double price;

  Service({required this.id, required this.name, required this.price});


  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}

final List<Service> services = [
  Service(id: 1, name: 'باقات فورجي 4 جيجا', price: 7.8),
  Service(id: 2, name: 'باقات فورجي 6 جيجا', price: 9.5),
  Service(id: 3, name: 'باقات فورجي 8 جيجا', price: 11.0),
  Service(id: 4, name: 'باقات فورجي 12 جيجا', price: 14.0),
  Service(id: 5, name: 'باقات فورجي 16 جيجا', price: 17.0),
  Service(id: 1, name: 'باقات فورجي 4 جيجا', price: 7.8),
  Service(id: 2, name: 'باقات فورجي 6 جيجا', price: 9.5),
  Service(id: 3, name: 'باقات فورجي 8 جيجا', price: 11.0),
  Service(id: 4, name: 'باقات فورجي 12 جيجا', price: 14.0),
  Service(id: 5, name: 'باقات فورجي 16 جيجا', price: 17.0),
];

class SearchDropDown extends StatefulWidget {
  const SearchDropDown({super.key});

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  @override
  Widget build(BuildContext context) {
    int selecedServiceId=0;

    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
          width: 600,

          child:  CustomDropdown<Service>.search(
            hintText: 'أختر الباقة',
              hintBuilder: (context,hint){
              return Text(
                hint,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                ),
              );
              },
              itemsListPadding: EdgeInsets.all(10),
            decoration: CustomDropdownDecoration(

              closedFillColor: Colors.white, // Change the text field color
              closedBorder: Border.all(
                width: 1,
                color: Colors.grey, // Change the border color
              ),
              closedBorderRadius: BorderRadius.circular(10), // Set the border radius
            ),
            items: services,
            overlayHeight:MediaQuery.sizeOf(context).height*0.54,
            searchHintText: 'ابحث عن باقة',
            noResultFoundText: 'لايوجد باقة بهذا  الأسم',
            excludeSelected: false,
            hideSelectedFieldWhenExpanded:true,
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              bool _isSelected = isSelected ?? false; // Convert isSelected to bool type
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _isSelected ? Colors.red : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Text(item.name),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration:  BoxDecoration(
                        color: Colors.teal.shade800,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Text("ر.ي${item.price.toString()}",textAlign: TextAlign.center,),
                    )
                  ],
                ),
              );
            },
            onChanged: (Service service) {
              selecedServiceId=service.id;
              setState((){});
              log('changing value to: ${service.id}');
            },

          ),
        ),

    );
  }
}
/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedOption = '';
  bool _isTextFieldVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Field with Animated TextField"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedOption.isNotEmpty ? _selectedOption : null,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
                  _isTextFieldVisible = true;
                });
              },
              items: <String>[
                'Option 1',
                'Option 2',
                'Option 3',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select an option',
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _isTextFieldVisible,
              child: AnimatedTextFieldAnimation(),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTextFieldAnimation extends StatefulWidget {
  @override
  _AnimatedTextFieldAnimationState createState() => _AnimatedTextFieldAnimationState();
}

class _AnimatedTextFieldAnimationState extends State<AnimatedTextFieldAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset(2.0, 0.0), // Start off-screen (to the right)
      end: Offset.zero, // End at center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: 200,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter text',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
*/

class AnimatedExpansionTile extends StatefulWidget {
  const AnimatedExpansionTile ({super.key});

  _AnimatedExpansionTileState createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,

      duration: Duration(seconds: 4), // Adjust duration as needed
      reverseDuration: Duration(seconds: 8), // Adjust duration as needed
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Expansion Tile'),
      ),
      body: ExpansionTile(
        title: Text('Expansion Tile'),
        trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
        onExpansionChanged: (value) => _toggleExpanded(),
        children: [
          AnimatedBuilder(

            animation: _animation,
            builder: (context, child) {
              return SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: _animation,
                child: child,
              );
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Expanded content goes here...',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


