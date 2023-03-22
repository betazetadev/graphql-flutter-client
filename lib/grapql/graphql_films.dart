String createFilmMutation = r"""
  mutation NewFilmMutation($film: film_insert_input = {}) {
    insert_film_one(object: $film) {
      film_id
      title
      description
      release_year
      language_id
      original_language_id
      rental_duration
      rental_rate
      length
      replacement_cost
      rating
      last_update
      special_features
      fulltext
    }
  }
""";

String editFilmMutation = r"""
  mutation EditFilmMutation($filmId: Int, $film: film_set_input = {}) {
    update_film(where: {film_id: {_eq: $filmId}}, _set: $film) {
      affected_rows
    }
  }
""";

String deleteFilmMutation = r"""
  mutation DeleteFilmByPK($film_id: Int = -1) {
    delete_film_by_pk(film_id: $film_id) {
      length
      film_id
      description
    }
  }
""";