Para el examen, considere lo siguiente
Para establecer login usen el servicio que cree en el ejemplo clase 7 final, recuerden que con ese servicio, pueden crear sus usuarios par hacer un login
Para el resto del ejercicio es decir, para crear los CRUD de Proveedores, Categorías y Productos utilice
Credenciales

 final String _baseUrl = "143.198.118.203:8000";

 final String _user = "test";

 final String _pass = "test2023";

# Endpoint
    Productos
    - Para listar use ejemplos/product_list_rest/ método GET 
    - Para agregar use ejemplos/product_add_rest/ método POST ejemplo json {"product_name":"nombre","product_price":100,"product_image":"https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto-1200x900.jpg"}
    - Para editar use ejemplos/product_edit_rest/ método POST ejemplo json {"product_id":1,"product_name":"nombre","product_price":100,"product_image":"https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto-1200x900.jpg","product_state":"Activo"} 
    - Para eliminar use ejemplos/product_del_rest/ método POST ejemplo json {"product_id":1} 

    Categorías
    - Para listar use ejemplos/category_list_rest/ método GET 
    - Para agregar use ejemplos/category_add_rest/ método POST ejemplo json {"category_name":"nombre"}
    - Para editar use ejemplos/category_edit_rest/ método POST ejemplo json {"category_id":1,"category_name":"nombre","category_state":"Activa"} 
    - Para eliminar use ejemplos/category_del_rest/ método POST ejemplo json {"category_id":1} 

    Proveedores
    - Para listar use ejemplos/provider_list_rest/ método GET 
    - Para agregar use ejemplos/provider_add_rest/ método POST ejemplo json {"provider_name":"nombre","provider_last_name":"apellido","provider_mail":"correo@correo.cl","provider_state":"Activo"} 
    - Para editar use ejemplos/provider_edit_rest/ método POST ejemplo json {"provider_id":1,"provider_name":"nombre","provider_last_name":"apellido","provider_mail":"correo@correo.cl","provider_state":"Activo"} 
    - Para eliminar use ejemplos/provider_del_rest/ método POST ejemplo json {"provider_id":1} 