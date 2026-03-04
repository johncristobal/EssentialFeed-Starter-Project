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

=============================================================
# Separating queries

### weak self
Usamos este para validar cuando la instnacia sea nula, temas de memoria
    store.retrieve { [weak self] result in
        guard let self = self else { return }

### skills
- dividir problmas en pequenos
a veces sueles encontrar informacion escondida

- al encontrar requisitos escondidos
* checa el deadline, notifica al equipo, documenta 

- bloated code (codigo inflado)
Command Query Separation (CQS)
A method should either perform an action (command) OR return data (query), but not both.

* Command
class BankAccount {
    private(set) var balance: Double = 0
    
    func deposit(amount: Double) {
        balance += amount
    }
}
Cambia estado y NO devuelve data

* Query
func getBalance() -> Double {
    return balance
}
Regresa data, NO cambia nada

EJEMPPLO
Query
func canWithdraw(amount: Double) -> Bool {
    return balance >= amount
}

Command
func withdraw(amount: Double) {
    balance -= amount
}

** En swift
A simple way of looking at it is that of Getters (Query) and Setters (Command/Modifier).

- Harmeos lo siguiente:
Load Cache (query) and Invalidate Cache If Needed (command).

=============================================================
# App-specific from app-agnostic

### separamos logica
Creamos tests para validar unicamente y otros para el sideefffect

### refactor
acomodamos metodos generales en archivos especifocs

### enum switch
- por una parte, si dejamos todos explicitos, cuando agregemos algo al enum, tronara y sabrenos que tenemos que ajustar
- si dejamos el default, hace el codigo flexible, pero si hay un nuevi caso debemos poner atencion a el
- la alternativa = @unknown default = genera un warning cuando se crea un caso en el enum y asi validar el codigo

### casos de uso
- describen logica de negocio de la app

### app-agnostics
Reglas y politicas - domain model
logica principal del negocio
Se reutiliza en los casos de uso

### app-specific 
solo logica especifica y comunicar para logica del negocio

=============================================================
# Separating / entities / single sources of truth / domain models

### reuzar politicas
Dejamos codigo con politicas clave en una clase aparte
Separar bussiness rules de modelos, controllers

Use cases - describe app-specific business logic - que se implementa en Contrllers
Domain model - describe aoo-agnostics business logic 
    - core
    - son pequenos, pero de gran impacto

###Frameowkrs
Que el frameowkr NO HAGA NADA DEL NEGOCIO
Mientras mas separes codigo, mas simple de manejar
Solo debe hacer lo simple = fetch, stre, download

### mover el currentDate fuera
es una funcion impura, mejor colocar el date dentro de la funcion como param

    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {

### OJO
Entities = models with identity (significa algo para el negocio)
- Two Entities with the same ID are considered identical, even if their values don’t match.

- Identidad, ua es algo par ala empresa
struct Money {
    let id: MoneyID
    let amount: Decimal
    let currency: Currency
}

value objects = models with NO identity = value type (data)
    - la policy has no identity, its deterministic
    - encapsula la regla
    - son reglas fijas, asi que las podemos dejar static

- solo data, simple
struct Money {
    let amount: Decimal
    let currency: Currency
}

### side effects
estos NO deben suceder en el core, debem estar al limite

FeedCachePolicy.validate
    - incovarcarlas con nombre, listo
    - no oucpampos una inicializacion, solo llamarlo como static

### Interesante los nombres
encapsula la relga de 7 dias en una regla fija
- one source of truth
renombreamos funciones, porque el dia de manana pueden ser 7 dias, 3 o un mes
de sevendays - expired

### DSL domain speficic language
reglas fijas, un metodo para manejar los 7 dias como fecha de expiracion

=============================================================
# Multithread env

### circulo verde con rojo
Core - sin side effects
Logica del negocio - high level
- LocalFeedLoader = core logic 

Limite del circulo = habilita la dependency inversion entre el core logic y FeedStore implementation

- Ejemplo
class UserViewModel {
    private let apiService = ApiService() // ❌ tightly coupled

- Mejor, usamos protocol para definir 
protocol UserService {
    func fetchUsers() -> [String]
}
- Definimos el service
class ApiService: UserService {
    func fetchUsers() -> [String] {
        return ["John", "Mary"]
    }
}
- Inyectamos el service
class UserViewModel {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func loadUsers() -> [String] {
        return userService.fetchUsers()
    }

Vamos inyectando el service
__Definition__
A boundary component, such as a protocol or closure, acting as an abstraction to guarantee the high-level component doesn’t depend on low-level details.

FeedStore - Codable, Realm, CoreData...
low level component

### Recuerda
Antes de tirar codigo - checa bien que necesitas
Checa todos los caminos, posibles rutas, race conditions
Eso deende de nosotrs

### Threads - cuidado
Si queremos insertar y eliminar al mismo tiempo
Si dos quieren insertar, mucho ojo

### contracts
casos de usos - ayudan al equipo a trabajar
incluso con el backend, definiendo data podemos empezar a trabajar sin el

=============================================================
# Codable system / measuring tests

### TDD rules
vemos un error, checamos compilador, corregimos y seguimos
"Make it work. Make it right. Make it fast. In that order."—Kent Beck

### Remember
expectatino block para simular network (lo que suele tardar)
    let exp = expectation(description: "Wait for cache retrieval")
    ...
    wait(for: [exp], timeout: 1.0)

### Codable
Implementa ambos tnato encodable y decodable
PERO OJO
Codable se coloca porque el framework lo requiere,
sin embargo el modelo LocalFeedImage no deberia ser afectado por ello, es logica de negocio

OJO
Al introducitr IO en los tests (Escribir en archivo) afectamos latencia de los test, y puede empeorar, hay que tener cuidado

* Creamos mappers *

### sideeffects
En los tests, al ejecutar uno, altera la app y puede que otro test ya no pase

- tearDown y setUp metodos lo podemos llamar para limpiar cache
setup se llama antes de cada test
teardown despues de cada test


### inyect param
Pasar el url como param nos ayuda a que otros usuarios puedan probar esta parte, usando cada uno su pripoia url


