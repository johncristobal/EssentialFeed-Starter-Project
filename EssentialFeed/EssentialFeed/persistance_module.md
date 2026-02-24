#  Persistance module

### URLCache

Woooow, existe un URLCache ya definido, donde podemos guardar data de la session

- Podemos cambiar el global state del cache, desde el inicio 
    URLCache.shared = cache

- espeficicamos que no queremos cache on esta opcion
    URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

- OJO
* Haremos un custom solution, no solo las default
* en los test, mucho cuidado con el orden, pueden afectar tests

### Aclarando requrimientos vs front design

- Definir, tener buena comunicacion
- unificar lenguage entre tecnicos y no tecnicos 
- Muy importante definir el tiempo para hacer CACHE y queh hacer en caso que est eantes o despues de ese tiempo
- CASO DE USO - recipies - pueden trabajar en conjunto
    * Load Feed Items - caso de uso
    * Load Feed Items Cache
    * Cache Feed 
    
- DEVELOP - social activity
    * obtenemos info mas alla del tech team
    * hacer los requerimientos mas precisos

=============================================================
#  Decoupling business frmo logic framework

- Separar business rules de frameworks - DependencyInversion
- Creamos clase para simular framework:
* probamos las interfaces sin ningun framework (coredata, codable)
    FeedStore {

- Dejamos que otro nos de la fecha, no lo manejamos en el test directamente

- podemos agregar cambios a commit recientes:
    git add .
    git commit --amend --no-edit
