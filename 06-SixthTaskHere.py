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

def select_movies(sort_by='title'):
    conn = create_conn()
    sort_by_options = ['title', 'release_date', 'rating', 'cost']
    if sort_by not in sort_by_options:
        sort_by = 'title'
        
    query = """ SELECT movie_id, title, release_date, rating, classification 
    FROM movies
    ORDER BY {sort_by};
    """
    rows = conn.run(query)
    
    columns = [col['name'] for col in conn.columns]

    return [
        {columns[i]: row[i] for i in range(len(columns))}
        for row in rows
    ]
    
"uncomment out the following line to see results ion terminal"
    
# if __name__ == "__main__":
#     from pprint import pprint
#     movies = select_movies()
#     pprint(movies)

    


