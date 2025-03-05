import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Movie> _allMovies = [];
  List<Movie> _trendingmovies = [];
  List<Movie> _popularmovies = [];

  Future<void> _loadMovie() async {
    final List<Map<String, dynamic>> allMoviesData =
        await _apiService.getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesData =
        await _apiService.getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesData =
        await _apiService.getPopularMovies();

    setState(() {
      _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
      _trendingmovies =
          trendingMoviesData.map((e) => Movie.fromJson(e)).toList();
      _popularmovies = popularMoviesData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilem'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // TODO: Panggil Method yang Menampilkan all Movies, Trending dan Popular
          children: [
            _buildMovieslist('All Movies', _allMovies),
            _buildMovieslist('Trending Movies', _trendingmovies),
            _buildMovieslist('Popular Movies', _popularmovies)
          ],
        ),
      ),
    );
  }

  Widget _buildMovieslist(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        //Movie
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final Movie movie = movies[index];
              return GestureDetector(
                onTap: () {},
                child: Padding(padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    ,height: 150,width: 100,fit: BoxFit.cover),
                    const SizedBox(height: 5),
                    Text(
                      movie.title.length > 14 ?'${movie.title.substring(0,10)}...' : movie.title ,  style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
