# Congelador para Ubuntu 18.04 y 20.04 para Mate basado en Ofris

Este software se puede utilizar como un congelador para Linux por línea de comando. Concretamente, se ha probado con Ubuntu 18.04 y 20.04, con entorno de escritorio MATE.

Este *script-shell* para *bash* de Linux, se basa en el congelador [Ofris](https://sourceforge.net/projects/dafturnofris-id/) desarrollado por Muhammad Faruq Nuruddinsyah.

El *script* original de Muhammad Faruq no funciona correctamente para las versiones 18.04 y superiores de Ubuntu, ya que estas gestionan la información del entorno de usuario de manera ligeramente distinta a lo que lo hacían las versiones predecesoras. Es por este motivo por el que se ha desarrollado esta nueva versión de congelador.

## Utilización del congelador

El *script* hay que ejecutarlo desde un usuario con permiso de administrador. Una vez descargado el *script*, hay que darle permiso de ejecución. Cuando se ejecuta en un *shell* o terminal, la aplicación muestra las siguientes opciones de menú.
1. Freeze for user <current_user>
2. Freeze for other user
3. Unfreeze for use <current_user>
4. Unfreeze for other user
5. View status for user <current_user>
6. View status for other users
7. Show system users
8. Set password
9. Exit

La utilidad de cada opción es:
1. Congela el usuario actual
2. Congela otro usuario (el programa pedirá el login del usuario)
3. Descongela el usuario actual
4. Descongela otro usuario (el programa pedirá el login del usuario) 
5. Indica el estado del usuario actual
6. Indica el estado de otro usuario (el programa pedirá el login del usuario)
7. Muestra todos los usuarios del equipo
8. Pone una clave a la aplicación
9. Termina el programa

## Funcionamiento del programa
Cuando se congela un usuario se guarda la información relativa a él en ese momento. El usuario puede editar su *home*, pero cada vez que se inicia de nuevo la sesión, se carga la información guardada por ofris, restableciendo el sistema al estado original en el que se guardó.


## Ficheros involucrados
La primera vez que se congele un usuario se creará una carpeta con la ruta **/etc/.ofris**.

Dentro de este directorio, a su vez, se creará:
- Una carpeta con el nombre de cada uno de los usuarios que se congela. Dentro de cada carpeta de usuario se almacena toda la información del *home* del usuario congelado. 
- Un fichero ***"user"-dconf-full-backup***, donde *"user"* es el login del usuario, con toda la información de respaldo del entorno de escritorio Mate obtenida con el comando *dconf dump /*
- Un fichero *ofris"user".sh* con el script que se ejecutará cuando se inicia la sesión

Además, se creará un fichero con nombre ***ofris"user".desktop*** dentro de la carpeta ***/etc/xdg/autostart/***. Este fichero tienen un enlace al fichero *ofris"user".sh* de la carpeta */etc/.ofris*, que es el que restaura el sistema del usuario. Cuando un usuario inicia una sesión se ejecutan estos *scripts*.
  
Es importante tener en cuenta que cuando se descongela un usuario lo que realmente sucede es que se borra el fichero *ofris"user".desktop* de la carpeta */etc/xdg/autostart/*. El resto de los ficheros, permanecen dentro de la carpeta */etc/.ofris*, por lo que si se desea es posible reestablecer manualmente la sesión del usuario. Pero, muy importante, si se vuelve a congelar el usuario se sobreescriben estos ficheros. Por lo tanto, puede ser recomendable crear una copia de seguridad del contenido de la carpeta */etc/.ofris*.
  
También, es importante tener en cuenta que cuando se elimina un usuario todos los ficheros permanecen en el sistema. Si posteriormente se vuelve a crear un usuario con el mismo nombre y se inicia sesión se restaurará con el estado que se tiene almacenado.
