Aplicación Móvil Amor Salvaje

- Aplicación móvil Amor Salvaje, hecha con Flutter y Dart. Conectada con la API de Express hecha en Flutter y Dart.

- Integrantes:

    - Matías Dittler
    - Miqueas Correa
    - Wanda Suárez
    - Brenda Yáñez

- Créditos:

    - Detalles de la creacion, dieño y asistencia del proyecto:

        - URL de la api de noticias para iniciar sesion para la parte de las noticias del home: 'https://newsapi.org/v2/everything?q=animals&page=$_page&apiKey=$apiKey', clave de Miqueas: '4a3e02f5c6a2485f907790cd2ee51bef'

        - Dentro de la carpeta lib tenemos todo esto:

            - Carpeta data:
                - En la carpeta data tenemos el archivo profile_data.dart creado por Matias contiene los datos de los integrantes del grupo para los datos de perfiles

            - Carpeta helpers:

                - En la carpeta helpers tenemos el archivo preferences.dart: Creado por matias para el tema dark/light y agregado de brenda para guardar el favoritos y la puntuacion del pez

            - En la carpeta models tenemos los archivos de modelos de animales y estrutucturas:

                - En la carpeta models tenemos la carpeta cats con el archivo cats_model.dart para manejar los datos obtenidos de la api y los nuevos datos agregados, creados por wanda

                - En la carpeta models tenemos la carpeta crocodiles con el archivo crcodiles_model.dart para manejar los datos obtenidos de la api y los nuevos datos agregados y el archivo list_crcodiles_model.dart para manejar la lista de crocodiles de la api, creados por matias

                - En la carpeta models tenemos la carpeta peces con el archivo fishes_model.dart para manejar los datos obtenidos de la api y los nuevos datos agregados y el archivo list_fishes_model.dart para manejar la lista de peces de la api, creados por brenda

                - En la carpeta structs tenemos los archivos de las estruturas que se mostrarar cuando los llamemos por id en la busqueda por id, archivo cats_struct.dart creado por wanda, archivo crocodiles_struct.dart creado por Matias, archivo dogs_struct.dart creado por Miqueas y el archivo fishes_struct.dart creado por Brenda

            - En la carpeta models tenemos tambien estos archivos:

                - archivo categories_model.dart creado por wanda para la busqueda por id

                - archivo cats_model.dart creado por wanda para el manejo del modelo de datos de la api

                - archivo dogs_model.dart creado por miqueas para el manejo del modelo de datos de la api

                - archivo list_dogs_model.dart creado por miqueas para el manejo del modelo de datos de la api para la lista de perros

            - En la carpeta observers tenemos el archivo loading_observer.dart creado por Matias, contiene algunos cambios hechos por brenda

            - En la carpeta providers tenemos:

                - La carpeta cocodrilos con el archivo crocodiles_provider.dart creado por matias

                - La carpeta peces con el archivo fishes_provider.dart creado por brenda

                - Archivo dogs_providers creado por Miqueas

                - Archivo loading_provider.dart creado por matias

                - Archivo theme_provider.dart creado por matias, contiene cambios agregados por brenda

            - En la Carpeta screens:

                - En la carpeta busqueda_id_screns tenemos estos archivos:

                    - animial_detail_screen.dart: Creado por Wanda, asistido por Miqueas con la busqueda por id y Brenda en un detalle de diseño.

                    - buscar_screen.dart: Creada por Wanda y asistida por Miqueas con la busqueda por id.

                - En la carpeta Crocodiles tenemos los archivo crocodiles_details_screen.dart, crocodiles_list_item.dart y crocodiles_list_screen.dart creadas por Matias para la busqueda por lista de cocodrilos y la presentacion de la carta de cada cocordilo

                - En la carpeta dogs tenemos el archivo dogs_details_screen.dart creado por miqueas para la busqueda por lista de perros y la presentacion de la carta de cada perro

                - En la carpeta drawer_menu.dart tenemos estos archivos:

                    - acerca_de.dart: Creada por Wanda, asistida en diseño por Matias y Miqueas, añadio el tema darkYlight Matias.

                    - animals_screen.dart: Creada por Brenda, añadio detalle de diseño miqueas

                    - explorar_screen.dart: Creada por Matias Matias, asistido por miqueas para adaptar cosas para brenda

                    - news_screen.dart: Creada por Miqueas

                - En la carpeta gatos tenemos los archivos cats_details_sreen.dart, cats_list_item.dart y cats_list_screen.dart tenemos los archivos creados por Wanda para la busqueda por lista de gatos y la presentacion de la carta de cada gatos.

                - En la carpeta home tenemos el archivo home_screen.dart: El diseño y la estructura fue creada por todos los integrantes desde una computadora, luego fue asistida por Brenda que creo y añadio la botonera desde github y por Wanda que creo la imagen del fondo y el texto.

                - En la carpeta list tenemos el archivo creado por dogs_list_screen.dart creado por miqueas para la busqueda por lista de perros

                - En la carpeta peces tenemos los archivos fishes_details_sreen.dart, fishes_list_item.dart y fishes_list_screen.dart tenemos los archivos creados por Brendaa para la busqueda por lista de peces y la presentacion de la carta de cada peces.

                - profile_detail_screen.dart: Creada y diseñada por Matias, asistido por algunos cambios de Brenda.

                - profile_screen.dart: Creada y diseñada por Matias, asistido por algunos cambios de Brenda y un detalle de disño de Miqueas.

                - screens.dart: Creado por Brenda para exportar las rutas de todos

            - En la carpeta search contiene la carpeta peces con los archivos searh_fishes.dart creada por brenda para la busqueda de peces

            - En la carpeta service contiene estos archivos:

                - animal_service.dart: creada por miqueas para añadir las etsrutucturas de los animales

                - api_service: creado por miqueas para hacer usar y hacer la peticion de la api

                - cats_service.dart: creado por wanda para manejar los datos obtenidos por la api en la busqueda por id

                - crocodiles_service.dart: creado por matias para manejar los datos obtenidos por la api en la busqueda por id

                - dogs_service.dart: creado por miqueas para manejar los datos obtenidos por la api en la busqueda por id

                - fishes_service.dart: creado por brenda para manejar los datos obtenidos por la api en la busqueda por id

            - En la carpeta widgtes tenemos lo siguiente:

                - La carpeta animals_drawer_menu con los siqguientes archivos:

                    - animal_card.dart: creada por brenda, asistida en diseño por miqueas y en estructura/logica por matias

                    - animal_details.dart: creada por brenda para la carta de los animales

                    - animal_history.dart: creado por brenda para la historia de los animales, asistencia de matias en estrutura/logica y diseño, asistencia de miqueas en diseño y adaptacion para brenda

                    - animal_pair.dart: creado por brenda para mostrar por pares a los animales

                    - custom_otlined_button.dart: creado por brenda, asistido por matias en diseño y estrutura/logica

                - La carpeta home que tiene el archivo scroll_horizontal.dart creado por miqueas para mostar las noticias en el home

                - animal_details.dart: creado por brenda, asistido en estrutura/logica y diseño por matias

                - botonera_navigation.dart: creado por brenda, con agregados de miqueas y matias, para navegar por los iconos de la botonera

                - category_card.dart: creado por wanda para mostrar las ctegorias de las cartas

                - custom_drawer.dart: El diseño, estructura/logica y la creacion fue hecha por todos en conjunto desde una compu, luego hubo modificaciones y agregados en el archivo por todos los integrantes

                - loading_animation.dart: Creado por matias, asistido por miqueas y brenda en diseño y estrtuctura/logica

                - loading_icon.dart: creado por matias contiene agregado de miqueas para adaptcion de brenda

                - lodingo_overlay.dart: creado por matias, contiene un agregado de cambios de brenda

                - profile_detail_card.dart: creado, diseñado y estructura/logica hechas por matias con un cambio de brenda

            Archivo main.dart creado, diseñado y estrutura/logica hechas por todos desde una compu, luego hubo cambios, modificaciones y agregados hechos por todos los integrantes

        - Fuera del lib en la carpeta assets tenemos todas las imagenes/gif que utilizamos en el proyecto con sus respectivas carpetas, agregadas por todos los participantes

        - En el pubspec.yaml tenemos todas las dependecias que utilizamos en el proyecto usadas por todos los participantes

    - Utilizacion de archivos en cada panatalla:

        - animal_detail_screen.dart utiliza estos archivos: animal_service.dart y categories_model.dart

        - buscar_screen.dart utiliza estos archivos: botonera_navigation.dart, categories_model.dart, category_card.dart y animal_detail_screen.dart

        - crocodiles_details_screen.dart utiliza estos archivos: botonera_navigation.dart, crocodiles_model.dart y shared_preferences.dart

        - crocodiles_list_screen.dart utilia estos archivos: botonera_navigation.dart, crocodiles_details_screen.dart, crocodiles_service.dart y crocodiles_model.dart

        - dogs_details_screen.dart utilizar estos archivos: dogs_model.dart

        - acerca_de.dart utiiza estos archivos: custom_drawer.dart

        - animals_screen.dart utiliza estos archivos: botonera_navigation.dart, custom_drawer.dart y animal_pair.dart

        - explorar_screen.dart utiliza estos archivos: loading_icon.dart

        - news_screen.dart utiliza estos archivos: custom_drawer.dart

        - cats_details_screen.dart utiliza estos archivos: cats_model.dart

        - cats_list_item.dart utiliza estos archivos: cats_details_screen.dart y cats_model.dart

        - cats_list_screen.dart utiliza estos archivos: cats_model.dart, cats_service.dart y cats_list_item.dart

        - home_screen.dart utiliza estos archivos: custom_drawer.dart, scroll_horizontal.dart y botonera_navigation.dart

        - dogs_list_screen.dart utiliza estos archivos: dogs_model.dart, dogs_detalis_screen.dart y dogs_service.dart

        - fishes_details_screen.dart utiliza estos archivos: fishes_model.dart

        - fishes_list_item.dart utiliza estos archivos: custom_drawer.dart

        - fishes_list_screen.dart utiliza estos archivos: botonera_navigation.dart, custom_drawer.dart, fishes_details_screen.dart, fishes_service.dart y fishes_model.dart

        - profile_detail_screen.dart utiliza estos archivos: profile_data.dart, theme_provider.dart, profile_detail_card.dart y botonera_navigation.dart

        - profile_screen.dart utiliza estos archivos: profile_detail_screen.dart y botonera_navigation.dart

        - screens.dart utiliza los archivos para importar las rutas que se van a exportar para usar en el proyecto

    - Widgets reutilizables:

        - Brenda:botonera_navigation.daart, custom_outlined_button.dart, animal_card.dart y animal_pair.dart

        - Miqueas: scrool_horizontal.dart

        - Wanda: category_card.dart

        - Matias: loading_animation.dart, loading_icon.dart, loading_overlay.dart y profile_detail_card.dart

- Explicacion para el cliente sobre la finalidad y funiconalidad de nuestra app de Amor Salvaje:

    La aplicación está diseñada para ofrecer una experiencia única y educativa, proporcionando información detallada sobre una amplia variedad de animales. Su objetivo principal es permitir a los usuarios explorar el reino animal de manera intuitiva y enriquecedora, con funciones que destacan por su utilidad y atractivo para los amantes de la fauna.

    Funcionalidades principales: 

        1. Exploración de animales y especies   

            - Visualiza un listado completo de especies clasificadas por tipo y accede a información detallada sobre cada una.

            - Realiza búsquedas individuales para encontrar rápidamente datos específicos sobre cualquier animal.  

        2. Favoritos y personalización
        
            - Marca tus especies favoritas para acceder a ellas fácilmente.  

            - Califica animales, agrega comentarios y comparte tus opiniones.  

        3. Educación e historia 

            - Descubre la historia y datos curiosos sobre cada animal para ampliar tu conocimiento del mundo natural.  

        4. Noticias y actualizaciones  

            - Mantente informado con noticias relacionadas con la vida salvaje, conservación y eventos del reino animal. 
        
        5. Galería de imágenes

            - Explora fotografías impresionantes de diferentes animales para conocerlos visualmente y apreciar su belleza.  

        6. Información de la aplicación y creadores 
        
            - Accede a una sección dedicada a la aplicación, donde encontrarás información sobre su propósito, los desarrolladores y detalles de contacto.  

            - Conoce a los creadores a través de perfiles detallados con sus datos personales.  

        7. Modo claro/oscuro 

            - Alterna entre los modos claro y oscuro para una experiencia visual personalizada y cómoda.

        8. Opiniones y retroalimentación  
        
            - Comparte tus sugerencias y opiniones sobre la aplicación para ayudar a mejorarla continuamente.

    Objetivo de la aplicación: 
    
        La app busca ser una herramienta integral para los amantes de los animales, promoviendo el aprendizaje, la conexión emocional y el disfrute de la biodiversidad. Es ideal para explorar información interesante sobre animales, descubrir nuevas especies y fomentar una mayor apreciación por la naturaleza.  

        Con esta propuesta, brindamos una experiencia inmersiva y amigable que combina educación, entretenimiento y personalización.