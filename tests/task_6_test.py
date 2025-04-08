import pytest
from task_6 import create_conn, select_movies, close_conn

def test_select_movies_returns_list():
    results = select_movies()
    assert isinstance(results, list)
    assert all(isinstance(movie, dict) for movie in results)
    
def test_movie_results_contain_keys():
    results = select_movies()
    assert len(results) > 0, "DB returned no movies"
    expected_keys = {'movie_id', 'title', 'release_date', 'rating', 'classification'}
    for movie in results:
        assert expected_keys.issubset(movie.keys())

def test_movies_output_is_alphabetical():
    results = select_movies()
    titles = [movie['title'] for movie in results]
    assert titles == sorted(titles), "Movies not in default alphabetical order"
    
def test_sort_by_rating_desc():
    results = select_movies(sort_by='rating', order='DESC')
    ratings = [movie['rating'] for movie in results if movie['rating'] is not None]
    assert ratings == sorted(ratings, reverse=True), "Movies not sorted by rating DESC"

def test_sort_by_release_date_asc():
    results = select_movies(sort_by='release_date', order='ASC')
    dates = [movie['release_date'] for movie in results if movie['release_date'] is not None]
    assert dates == sorted(dates), "Movies not sorted by release_date ASC"
    
def test_min_rating_filter():
    min_rating = 7.0
    results = select_movies(min_rating=min_rating)
    for movie in results:
        if movie['rating'] is not None:
            assert movie['rating'] > min_rating, f"Movie rating {movie['rating']} is not above {min_rating}"
            
def test_invalid_sort_by_raises_error():
    with pytest.raises(ValueError) as e:
        select_movies(sort_by='invalid_column')
    assert "Invalid sort_by" in str(e.value)

def test_invalid_order_raises_error():
    with pytest.raises(ValueError) as e:
        select_movies(order='wrong')
    assert "Invalid order" in str(e.value)


