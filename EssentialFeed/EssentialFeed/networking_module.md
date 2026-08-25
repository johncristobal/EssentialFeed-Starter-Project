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
**Eliminamos singleton by DI**
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
- Usamos arrays para esto

OJO con los states
    public enum HTTPClientResult {
        case success(HTTPURLResponse)
        case failure(Error)
    }

- Con este, ya no jugamos con muchos states, solo con dos y su respectivo valor

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

### map
agregamos funcion aparte para solo llamar en success
funcion map (como el otro curso)

### weak self
guardl self != nil else {return}
Ocupamos esto por si la instancia ya no esta, entonces ya no puede ejecutar lo demas

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
requieres la url, aun no tenemos, ni backend

### Subclass vs Protocol...
Subclass tnemos que usar la clase y nos preocupamos de los otros metodos
URLSession - muchos metodos por override
- can be dangerous when we subclass types we don’t own.
- OJO,una cosa es crear el task y otra el resume task, dos test diferetnes
    - aunque van ligados, pueden ser un solo test 

### Protocols
Con protocol, solo definimos la clase que ocupams y ya
HttpSession - protocol custom y solo ocupampos ese metodo o metodos definidos en el prococol
- we only have to implement and maintain specific methods we care about. 
OJO
- we introduce a lot of noise in our production code, as the protocols are created solely for testing purposes.

### URLProtocol Stub (la preferida del profe)
clase custom para tests url, http, https, ftp
URL Loading System

class func canInit(with:URLRequest) -> Bool
class func canonicalRequest(for:URLRequest)
func startLoading()
func stopLoading()

=============================================================
# Speed up development

### setUp and tearDown
Metodos que se invocan al inicio y fin de cada test

### validar todos los casos
haces varios casos para que valides diferentes valores
    XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
    XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: nil))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: nil)) 

### duplicate code
    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #file, line: UInt = #line) -> Error? {
        let result = resultFor(data: data, response: response, error: error, file: file, line: line)

        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
    }
Mucho ojo para cuando duplicas codigo
- est ecodigo es el mismo para varios test, se manda la data, response y error
- extension
- helpers
Nombres - deben ser claros y expresar lo que estas haciendo 
- NSError

=============================================================
# random / end to end test 

### Opciones de test, random, parallel, code coverage
enabled random test in edit scheme
- por si estuviesen anclados los tests, con esto cehcmoas que no haya y corran todos los test ok

enabled parallel test
- para checar temas de velocidad, mas rapido

code coverage
- para ver que todo el codigo esta optimizado, ver que tanto corre
- ayuda a ve rque todas las lineas de codigo se ejecutne
- no es el goal, pero si se recomienda 

### EndToEnd Tests
- OJO, podemos crear un url fake que devuelva la data esperada (proactividad)
    - podemos verifica si hay cambios en backends
    - Crea una cuenta prueba por app, fuertes passwords
- Creamos nuevo TARGET para esto, para verificar tiempos exactos, mas precisos
    - no queremos todos los test corriendo aqui
    - desde main view, + target, test bundle
    
- agregar mensajes en los test, pata quesea mas claro
    XCTAssertEqual(data, "mesaje")
    
- OJO con el helper
- Seleccionamos y en panel derecho agregamos a target nuvo

= = =
OJO con esto
Una y otra vez, el setup se lleva a un helper function

### CI scheme (continous integration)
Creamos nuevo SCHEME
Para probar todos los antes antes de lanzar a master branch

# githubactions
https://www.youtube.com/watch?v=HpitZtTDa3M&t=2s

- Creamos carpeta .github/workflows/ci.yml en root del proyecto
- Adecuadmos instruccinoes (ver archivo)
- hacemos push a master, empiezan a correr test
[![CI](https://github.com/johncristobal/EssentialFeed-Starter-Project/actions/workflows/CI.yml/badge.svg)](https://github.com/johncristobal/EssentialFeed-Starter-Project/actions/workflows/CI.yml)

=============================================================
# thread sanitizer
- ayuda a ver si hay data races at runtime (muchos hilos ingresando al mismo endpoint al mismo tiempo) 

- habilitamos opcion en edit schema - diagnostics
stopIncetrceptingRequests() = se llama en main en el tearDown
Mientras otro hilo intenta acceder a stub data compartido

    makeSUT().get(from: url) { _ in }
En esta linea, no estamos esperando que se termine el request, solo que se llame

- OJO
esto puede causar inremente en CPU de 2 a 20, 
- NO SE recomienda activarlo, solo en CI para validar tests

=============================================================
# wrong reachability
validar si tenemos conexion o no y dar el siguiente paso

- Desde ios 11, tenemos la flag waitsForConnectivity para esperar cuano haya conexino
- definir timeout para definir cuando termina
- delegate para saber si hay conexion
- request.allowsCellularAccess para conexionss con celular data

### ahroa en iOS 13+
- allowsExpensiveNetworkAccess - si se usa una interfaz de red si el sistema lo considera costoso
- allowsConstrainedNetworkAccess - saber si se usa la red si el usuario especifico Low data mode

No bloquees nada basado en pre-flight checks


