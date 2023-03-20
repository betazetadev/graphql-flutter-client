import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_client/view/new_film_form_page.dart';
import 'package:graphql_flutter_client/widget/alphabetical_selection_list.dart';
import 'package:graphql_flutter_client/widget/year_horizontal_selection_list.dart';

import 'model/film.dart';

String fetchAllFilms = r"""
  query FetchAllFilms {
    film {
      title
      fulltext
      description
    }
  }
""";

String fetchFilmsFromYear = r"""
  query FilmsFromYearQuery($year: Int = 2023) {
    film(where: {release_year: {_eq: $year}}) {
      description
      film_id
      fulltext
      language_id
      last_update
      length
      original_language_id
      rating
      release_year
      rental_duration
      rental_rate
      replacement_cost
      title
      special_features
      language {
        language_id
        last_update
        name
        code
      }      
    }
  }
""";

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'http://10.0.2.2:8080/v1/graphql',
    );
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );
    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedYear = 2023;
  late final GraphQLClient graphQLClient;

  void _onYearChanged(int year) {
    setState(() {
      selectedYear = year;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewFilmFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          YearHorizontalSelectionList((year) {
            _onYearChanged(year);
          }),
          Expanded(child: GraphQLConsumer(
            builder: (GraphQLClient client) {
              return FutureBuilder(
                  future: client.query(QueryOptions(
                    fetchPolicy: FetchPolicy.networkOnly,
                    document: gql(fetchFilmsFromYear),
                    variables: <String, dynamic>{
                      'year': selectedYear,
                    },
                  )),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      final films = (snapshot.data as QueryResult)
                          .data!['film']
                          .map<Film>((film) => Film.fromJson(film))
                          .toList();
                      return AlphabeticalSelectionList(items: films);
                    }
                    return const CircularProgressIndicator();
                  });
            },
          )),
        ],
      ),
    );
  }
}
