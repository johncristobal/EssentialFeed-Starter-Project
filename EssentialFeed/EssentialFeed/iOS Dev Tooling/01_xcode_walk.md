#  Xcode Walkthrough

### Assitant

=====
Editor - assistant
para visualizar archivos relacionados entre si, interfaces, classes, tests

=====
Configuration
Por default tenemos dos - 
- release 
    - optimiza binario, memoria
    - se usa en archive option
    
- debug 
    - no optimiza
    - se usa en run options

* Podemos crear mas, por ejemplo staging (version prod para pruebas local)

=====
Target and project
- Cambiar versiones
- Capabilities (push notiifcations)
- resources. . .
- build settings - modificar aspectos del build
    resolved => target settings - target file - project settings - project file - platform defaults
    se van sobreescribiendo entre deafults, project y target
- build phases
    dependencias
    aqui podemos especificar algunas dependicas par acelerar previews o devs
- build rules
        
=====
pbxproj format - 35:03
PBXProject - target, versions, et 
XBuildConfiguration - debug, release => para cada target

=====
Project
AppDelegate / SceneDelegate - compositionRoot
Assets - images, colors
info.plist - settings
products
frameworks
