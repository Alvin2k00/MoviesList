import 'package:flutter/material.dart';

void main() => runApp(new MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'My Movies List',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF00BCD4)),
        home: new MoviesList()
    );
  }
}

class MoviesList extends StatefulWidget {
  @override
  createState() => new Moviesdelorupd();
}

class Moviesdelorupd extends State<MoviesList> {
  List<String> moviesnames = [];

  void _addMovie(String task) {

    if(task.length > 0) {

      setState(() => moviesnames.add(task));
    }
  }

  void _deleteMovie(int index) {
    setState(() => moviesnames.removeAt(index));
  }

  void _alertingRemoveMovie(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Remove Movie "${moviesnames[index]}" from the list?'),
              actions: <Widget>[
                new TextButton(
                    child: new Text('CANCEL'),

                    onPressed: () => Navigator.of(context).pop()
                ),
                new TextButton(
                    child: new Text('REMOVE MOVIE'),
                    onPressed: () {
                      _deleteMovie(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  Widget _buildMovieList() {
    return new ListView.builder(
      itemCount: moviesnames.length,
      itemBuilder: (context, index) {

        if(index < moviesnames.length) {
          return _buildMoviename(moviesnames[index], index);
        }
        return _buildMoviename(moviesnames[index], index);
        },
    );
  }


  Widget _buildMoviename(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText),
        onTap: () => _alertingRemoveMovie(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('My Movies List')
      ),
      body: _buildMovieList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add Movie',
          child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    
    Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new movie to be watch')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addMovie(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter a movie name that you want to watch...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }
}
