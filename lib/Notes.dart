//1.
//  final String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
//  final String formattedDateandTime =
//      DateFormat('kk:mm \n EEE d MMM').format(DateTime.now());

//2.
// bottomNavigationBar: Builder(builder: (BuildContext context) {
//            return BottomAppBar(
//              color: Colors.orange,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  IconButton(icon: Icon(Icons.menu), onPressed: () {
//                    Scaffold.of(context).openDrawer();;
//                  }),
//                  IconButton(icon: Icon(Icons.message), onPressed: () {}),
//                ],
//              ),
//            );
//          },),
//          drawer: Drawer(
//            child: SafeArea(
//              right: false,
//              child: Center(
//                child: Text('Drawer content'),
//              ),
//            ),
//          ),

//3.body: Stack(
//        children: <Widget>[
////          Positioned(
////            child: AppBar(
////              backgroundColor: Colors.transparent,
////              elevation: 0,
//////              actions: <Widget>[
//////
//////              ],
////            ),
////          ),

//4. no shadow bottom button
//Align(
//            alignment: Alignment.bottomCenter,
//            child: Padding(
//              padding: const EdgeInsets.all(15.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.calendarAlt),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Calender(),
//                        ),
//                      );
//                    },
//                    tooltip: 'Calendar',
//                  ),
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.home),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Todo(),
//                        ),
//                      );
//                    },
//                    tooltip: 'TodoList',
//                  ),
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.stickyNote),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Notes(),
//                        ),
//                      );
//                    },
//                    tooltip: 'Notes',
//                  ),
//                  FlatButton(
//                    child: Text('TODO'),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => ToDos(),
//                        ),
//                      );
//                    },
//                  ),
//                ],
//              ),
//            ),
//          ),

//4. add theme data to a certain element
//Theme(
//              data: ThemeData(
//                  canvasColor: Colors.transparent, buttonColor: Colors.white),
//data: Theme.of(context).copyWith(
//canvasColor: Colors.transparent,
//                primaryColor: Colors.white,
//                textTheme: Theme.of(context).textTheme.copyWith(
//                      caption: TextStyle(color: Colors.white),
//                    ),
//),
//child: BottomNavigationBar(

//final text = 'hello stack overflow';
//Text(text.length > 3 ? '${text.substring(0, 3)}...' : text);

//TextFormField(
//  inputFormatters: [
//    new LengthLimitingTextInputFormatter(42),
//  ],
//);
