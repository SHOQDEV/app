const url = 'https://artistica-backend.herokuapp.com/api';

seviceAuth() => '$url/auth/login';

serviceCategory(String? id) => id==null?'$url/categorias':'$url/categorias/$id';

serviceProduct(String? id) => id==null?'$url/productos':'$url/productos/$id';