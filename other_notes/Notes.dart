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
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Padding(
//              padding: const EdgeInsets.all(15.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      IconButton(
//                        icon: FaIcon(FontAwesomeIcons.stickyNote),
//                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => screens.Notes(),
//                            ),
//                          );
//                        },
//                        tooltip: 'screens.Notes',
//                      ),
//                      Text('screens.Notes'),
//                    ],
//                  ),
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.smile),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Meditate(),
//                        ),
//                      );
//                    },
//                    tooltip: 'Meditate',
//                  ),
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.clock),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Pomodoro(),
//                        ),
//                      );
//                    },
//                    tooltip: 'Pomodoro',
//                  ),
//                  IconButton(
//                    icon: FaIcon(FontAwesomeIcons.calendarAlt),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Todo(),
//                        ),
//                      );
//                    },
//                    tooltip: 'Todo',
//                  ),
//                ],
//              ),
//            ),
//          ),

//5. add theme data to a certain element
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

////      body: IndexedStack(
////          index: _currentIndex,
////          children: _children = [
////            HomePage(),
////            Calender(),
////            screens.Notes(),
////            Todos(),
////          ]),

// this only works with ListView
//  RefreshIndicator(
//  onRefresh: _updateData,
//  child: ListView())

//  Future<void> updateImage() async {
//    try {
//      homePageImageURL = Constants.homePageImage;
//    } on SocketException catch (_) {}
//  }

//  article.imageURL == null
//  ? Image.asset("images/news-placeholder.png")
//      : Image.network(article.imageURL),

//https://flutter.dev/docs/cookbook/gestures/dismissible
//https://stackoverflow.com/questions/46528447/is-there-a-better-way-to-check-left-right-drag-in-flutter
//                                    Dismissible(
// Each Dismissible must contain a Key. Keys allow Flutter to
// uniquely identify widgets.
//type 'TodoModel' is not a subtype of type 'String'
//                                    key: Key(snapshot.data[index - 1]),
// Provide a function that tells the app
// what to do after an item has been swiped away.
//                                    onDismissed: (direction) {
//                                      // Remove the item from the data source.
////                                      setState(() {
////                                        snapshot.data.removeAt(index);
////                                      });
////                                      TodoDBHelper.instance.deleteTask(todo.id);
////                                      //we need to update the task list, this function already has setState()
////                                      _updateTodoList();
//
//                                      // Then show a snackbar.
//                                      Scaffold.of(context).showSnackBar(SnackBar(
//                                          content: Text(
//                                              "${snapshot.data[index - 1]} dismissed")));
//                                    },

//                  Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Stack(
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            IconButton(
//                              icon: Icon(Icons.arrow_back_ios),
//                              iconSize: 40,
//                              onPressed: () {
//                                Navigator.pop(context);
//                              },
//                            ),
//                            Spacer(),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              'My Todo',
//                              style: TextStyle(
//                                color: Colors.white,
//                                c,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
