import pg8000.native
from dotenv import load_dotenv
import os

'''Create the function select_movies. It should return a list of movie dictionaries from your locally hosted movies table.

Each movie should contain the following keys:

movie_id
title
release_date
rating
classification
The default order of the movies should be alphabetically by title.

The function will also accept additional arguments (sort_by, order & min_rating) to filter/rearrange the returned movies list based on the argument
'''
def create_conn():
    load_dotenv()
    conn = pg8000.native.Connection(
    database=os.getenv('DATABASE'),
    user=os.getenv('USER'),
    password=os.getenv('PASSWORD'),
    host=os.getenv('HOST'),
    port=int(os.getenv('PORT'))
)
    return conn

def close_conn(conn):
    if conn:
        conn.close()

def select_movies(sort_by='title', order='ASC', min_rating=None):
    sort_by_options = ['title', 'release_date', 'rating', 'cost']
    order_options = ['ASC', 'DESC']
    
    # if sort_by not in sort_by_options:
    #     sort_by = 'title'
        
    # if order not in order_options:
    #     order = 'ASC'
        
    if sort_by not in sort_by_options:
        raise ValueError(f"Invalid sort_by: {sort_by}. Must be one of {sort_by_options}")
    
    if order not in order_options:
        raise ValueError(f"Invalid order: {order}. Must be one of {order_options}")
        
    conn = create_conn()
    
    try:
        query = f""" SELECT movie_id, title, release_date, rating, classification 
        FROM movies
        ORDER BY {sort_by} {order};
        """
        rows = conn.run(query)
        
        columns = [col['name'] for col in conn.columns]

        movies = [
            {columns[i]: row[i] for i in range(len(columns))}
            for row in rows
        ]
        
        if min_rating is not None:
            movies = [movie for movie in movies if movie['rating'] and movie['rating'] > min_rating]

        # if order == 'DESC':
        #     movies.reverse()
        
        return movies
    finally:
        close_conn(conn)
    
"uncomment out the following line to see results ion terminal"
    
# if __name__ == "__main__":
#     from pprint import pprint
#     movies = select_movies()
#     pprint(movies)



