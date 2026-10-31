#  SOLID principles
- Single responsability
a componente should have only one responsability 
and or -> mas de una cosa, violacion 

- Open-closed
should modify a behaviour without changing existing code
open for extension, closed for modification
un sistema no puede ser 100% open closed

+ Liskov substitution
object should be replacable with instances of their subtypes
without breaking the system

- Interface segregation
clients shoulkd not depend on methods they not use

- Dependency inversion
high level modules should not depend on low-level modules
they should both depend on abstraction 
  - high level - business rules - modesl, services
  - low level - viewmodel, ui

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
SRP and ISP - small things 
composable, **testable**, easy to mantain, extend, reuse, replace, etc

formatters
- deben vivir en viewmodel, no en views, viewscontrollers

\vars computed
```
private var isIndepentResult: Bool {
return session == nil
}
```

Responsabilidades
\* recuerda, la logica va en viewmodel, presenter.no en views..

Un meotod, varias implementaciones
* serapamos addandorupdate en dos metodos con el mismos service
- save se usa en ambos, se separa mejor, mas claro 

Decorator
* agregar funcoinalidad aparte, y pasar ese decorator 
* ***estudiar mas a fondo este patron***

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

