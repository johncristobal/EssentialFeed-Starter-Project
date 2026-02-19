=============================================================
#  Singleton to DI

### Test 1
Dado un cliente, sin llamar al sut
La url debe ser nil
XCTAssertNil(client.requestedUrl)

### Test 2
Arrange: Given a client and a sut
Act: When we invoke sut.load
Assert: Then assert that a URL request was initiated in the client
- Dado un cliente y sut, al llamar a load, iniciamos el url (NO debe ser nil)
XCTAssertNotNil(client.requestedUrl)

### Tip 1:
Para clases abstractas, usamos Protocol
    protocol HTTPClient {
        func get(from url: URL)
    }

- hacemos el codigo mas flexible, abierto a *extensiones* (como alamofire, urlsession). . .y mas testeable

### Tip 2:
Es muy raro tener Singletons, pasamos de esto a protocolos
- Conforme vas avanzando, se va armando el protocolo

### Tip 3:
Eliminamos singleton by DI
Singletons deben tener buenas razones

class RemoteFeedLoader {    
    let client: HTTPClient

- Inyectamos el HTTPClient a RemoteFeedLoader como dependencia
- Mantenemos el principio OpenClosed 

### lecture
Pasos pequeños y seguros, llegamos asi al protocol
Llevamos de un singleton a un protocol bien estructurado 
Usamos DI para pasar la responsabilidad a otros componentes

=============================================================
#  Module control

### Folders
Separamos en carpetas 

### testable
podemos agregar @testable, pero es mejor hacerlo publico para que podamos testar tal cual 

### Final
final classes = no habra sublcases de esa clase

### array
cambiamos la forma de hacer tests a array
podemos manipular un poco la cantrida de llamadas y validar si son las correctas

=============================================================
#  Handling errors, invalid paths

### Test 3
Dado un sut y un cliente que siempre falla
When intentamos cargar info
Then esperamos un error de conectividad

### stub vs spy
A stub replaces a dependency and returns predefined data.
- You want to control the input/output of a dependency
- You don’t care how many times it was called
- You only care about the result of the system under test

A spy records how it was used.
- You want to verify a method was called
- You want to check how many times it was called
- You want to verify parameters passed

=============================================================
#  Classicist TDD to map json + domain models

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
Ahora, ajustamos para obtener data de la respuesta para validar en tests

private struct Item: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL

    var item: FeedItem {
        return FeedItem(id: id, description: description, location: location, imageURL: image)
    }
Uso de un mapper para transformar el item descrito en el contrato con uno para testear, esto es util par no modificar el FeedItem definido

].compactMapValues { $0 }
Delete nil values 

private func expect( sut: RemoteFeedLoader, toCompleteWith result: RemoteFeedLoader.Result, when action: () -> Void,
Checa como espera una action

expect(sut, toCompleteWith: .success(items), when: {
    let json = makeItemsJSON([item1.json, item2.json])
    client.complete(withStatusCode: 200, data: json)
})

al llamarlo, se usa el clousure para invocar action y validar test

=============================================================
# Automating memory leak + async bug

### final
Recuerda que final es porque no heredaran a otra clase

### addTeardownBlock
memory leak detection

### cada error en su linea
file: file, line: line
Recuerda agregar estos para que cada error se refeleje en su metodo respectrivo

=============================================================
# modularity + enum patterns

DRY - dont repeat yourself

### Habia mucho repeetido

    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
ahora solamente es
    
    public typealias Result = LoadFeedResult

usamos solo uno generico
If you’re using Swift 5 or above, you can use the Swift.Result
Ya aprenderemos a usar este mas adelante

=============================================================
# Four approaches

### end to end
requieres la url, aun no tenemos

### Subclass vs Protocol...
Subclass tnemos que usar la clase y nos preocupamos de los otros metodos
URLSession - muchos metodos por override
- can be dangerous when we subclass types we don’t own.

Con protocol, solo definimos la clase que ocupams y ya
HttpSession - protocol custom y solo ocupampos ese metodo o metodos definidos en el prococol
- we only have to implement and maintain specific methods we care about. 
OJO
- we introduce a lot of noise in our production code, as the protocols are created solely for testing purposes.

### URLProtocol Stub (la preferida del progfe)
clase custom para tests url, http, https, ftp
URL Loading System

=============================================================
# Speed up development

### setUp and tearDown
Metodos que se invocan al inicio y fin de cada test

### duplicate code
Mucho ojo para cuando duplicas codigo
- extension
- helpers
Nombres - deben ser claros y expresar lo que estas haciendo 
- NSError

=============================================================
# random / end to end test 

enabled random test in edit scheme
- por si estuviesen anclados los tests, con esto cehcmoas que no haya y corran todos los test ok

enabled parallel test
- para checar temas de velocidad, mas rapido

code coverage
- para ver que todo el codigo esta optimizado, ver que tanto corre
- ayuda a ve rque todas las lineas de codigo se ejecutne
- no es el goal, pero si se recomienda 

EndToEnd 
- OJO, podemos crear un url fake que devuelva la data esperada (proactividad)
    - podemos verifica si hay cambios en backends
    - Crea una cuenta prueba por app, fuertes passwords
- Creamos nuevo TARGET para esto, para verificar tiempos exactos, mas precisos
    - no queremos todos los test corriendo aqui
    

= = =
OJO con esto
Una y otra vez, el setup se lleva a un helper function

### CI scheme (continous integration)
Para probar todos los antes antes de lanzar a master branch

