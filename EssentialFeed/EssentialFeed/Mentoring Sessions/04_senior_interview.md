#  Senior iOS Developer Interview
##### What kind of projects do you like to work with?
Proyectos donde pueda ser parte de algo grande, demostrar mis habilidades, aportar a la empresa y entregar grandes productos

##### What's the iOS project you're most proud of? 
Mi primer app donde aplique todo mi conocimiento, despues fue aprendiendo nuevas cosas y fui mejorando mi codigo 
Una app donde aprendi muchisimo, fue un reto involucrarme en todo el proceso y sacar el trabajo con buen tiempo

##### What are you looking for a new role? 
Nuevos retos, oportunidades donde pueda crecer y demostrar mis habilidades a la empresa

##### How do you keep up to date and improve skills?
Leer blogs de Medium, cursos, Apple WWDC
Poner en praactica:
* Guitarra, no praacticas en el escenerio, lo haces antes 
- Buscar el tiempo para hacerlo
- **Portafolio, contenido, que vean tu contenido **

##### Whats your favorite iOS app and why?
. . .

=========================
#### **TDD excersise**
Write program that prints 1 - 100
multiples of 3 - Fizz
multiples of 5 - Buzz
Both - FizzBuzz
Default -> number

* iOS app no es necesario, con un macos framework es suficiente, no hay UI
- No temas hacer preguntas, relax 
- DRY principle, si repites codigo, refactor de una
- Solluciones snecillas al inicio, ve refactorizando. mejorand codigo
  - no te metas con enum, ve a lo facil 
  - Si el codigo es sencillo, funciona, no sobrepienses con refactor raros 

**Estar al dia con el lenguaje**
- numero % 15 == 0, esta ok, perp
- number.isMultiple(of: 15) es mejor

#### Tips
* Ir guardando progreso - git
- Test pass, commit
- Ojo con los nombres, queden claros

=========================
#### **Questions**

What does mean clean code to you?
- codigo entendible, mantenible, testeable, y extendible

how do your test your code / apps?
- unit test(logic) and ui test (flows)

How do you design / architech your apps? 
* Separar modulos, frameworks - logica - facil de test
- Capas de dominio - reglas de negocio
- limites - protocolos para conmunicar capas
- Combine 

Commonly design patterns? 
* MVVM, MVC, VIPER
- notification, singleton, observer patterns
- uiresponser, facade, 

Array, set, dict
* array - orderder items (index)
- set - unordered unique items 
- dict - unordered collection key-values pairs 

Value vs reference type
* value - copias, inmutable
  - stored in stack memory 
- reference - shared instance, mutable  
  - stored in heap - dynamic memory 

set up core data stack
* no contestar con codigo, entender la persistencia y como usarla
- en backgraou thread

Apply Dependency  Injection
* 

continuois integration CI
* merge a master branch - integrar continuamente el codigo
- mediante github, ir uninedo, esto es integration
- tests

continuos deployment CD
* teniendo en master - deployamos automatico
- siempre listo para deply

static and dynamic libraries 
* staic - en tiempo de compilacion - se va el zip de archivo, libs
- dynaimc - en runtime - se pueden reemplazar sin compilar

find and fix memory leaks
* instrments 

delegation
* para comunicar dos objetos 

escaping keyowrd in swift
* para closures, cuando quieras que se ejecuten afuera 
- sake of memory managment - gestion de memoria

lazy
* no se inicializa al inicio
- solo cuando se llama - tareas kargas como coenctar a DB

dynamic dispatch
* 

final
* define una clase/metodo/func que no podra ser heredada

PRACTICE, PRACTICE, PRACTICE
