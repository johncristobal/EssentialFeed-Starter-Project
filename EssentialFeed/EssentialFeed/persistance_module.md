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
***
Dependency Inversion. Instead of depending on framework requirements/details, we make the framework depend on our needs.
***

- Creamos clase para simular framework:
* probamos las interfaces sin ningun framework (coredata, codable)
    FeedStore {

- Dejamos que otro nos de la fecha, no lo manejamos en el test directamente

- podemos agregar cambios a commit recientes:
    git add .
    git commit --amend --no-edit

- agregamos enum para simplicaficar proceso
- una vez mas con el metodo spy
- OJO con el arreglo de enum (aqui me perdi un poco)
private class FeedStoreSpy: FeedStore {
    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert([FeedItem], Date)
    }

    private(set) var receivedMessages = [ReceivedMessage]()

- TIPS
* The Single Responsibility Principle (SRP) is a great guideline. Ask yourself: are all methods related and responsible for one and only one responsibility 

* Interface Segregation Principle (ISP): no client should be forced to depend on methods it does not use.

=============================================================
#  Modules

Controllers - what
Frameworks - how
OJO
- si muchas flechas aputan a un componente, que pasa is cambia?
- un cambio en el, desencadenaria muchos mas 

- Temas de memoria
Probamos cuando se inserta o se borra y el Loader se va a nil

=============================================================
#  Resolviendo el high-coupling - data transfer model

Queremos componentes descentralizados 
- Cada modelo para su dominio 
Por eso creamos un FeedItem => LocalFeedItem === DTO
DTO = data transfer object 
- Si un modeo cambia, no afecta al local
- Creamos mappers para match models

Creamos capas en caso que backend cambie 

- - -
### Alcance conformista
unico modelo para todo -> puede ser un error
Un cambio y se mueve todo

### Naming

Ver un producto tecnicamente y no
Item = iamge, ads or videos
Para nosotros, primero solo imagenes 

- INTERESANTE:
private Array extensions for translating/mapping between model representations

testing only through the public interfaces:

=============================================================
# DRY principle, Tiny DSLs

Interesante: hace un duplciado de funcion, pero en un contexto diferente
Podemos usar lo mismo para diferentes contextos

- este es el camino...
sut.load { images, error 
}

- pero, podemos simplicar
sut.load { result 
}

haciendo uso de los protocolos

### typealias
proteger codigo de cambios futuros

### expect function
entendiendo un poco mas el expect function to send expected result y comparar con receive result 
switch interno para hacer matches

### enum
para cuando tienes mas de un caso, son buenos para comparar muchos casos

### WHAT
case let ... where method()
woooow, validar case con una funcion interna xD

### DSL (Domain Specific Language) 
detalles de implementacion 
test-specific DSL (Domain Specific Language) making the tests more flexible as we are free to reuse/change/replace the logic within the Date extension without breaking the tests.

### OJO con calcuclar fechas
un calculo de 60*60*24*7 puede ser error para todos los dias
ademas de las zonas horarios de diferetes devs en el mundo
- Dejemoslo en Apple Calendar 

### Triangular
Si el esceneario es menos de 7 dias...minimo
- pero si es mas de 7
- si es justo 7

Como devs, nos toca validar todo escenario => PRACTIVIDAD

