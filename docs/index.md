# Congelador para Ubuntu 18.04 y 20.04 para Mate basado en Ofris

Este software se puede utilizar como un congelador para Linux por línea de comando. Concretamente, se ha probado con Ubuntu 18.04 y 20.04, con entorno de escritorio MATE.

Este *script-shell* para *bash* de Linux, se basa en el congelador [Ofris](https://sourceforge.net/projects/dafturnofris-id/) desarrollado por Muhammad Faruq Nuruddinsyah.

El *script* original de Muhammad Faruq no funciona correctamente para las versiones 18.04 y superiores de Ubuntu, ya que estas gestionan la información del entorno de usuario de manera ligeramente distinta a lo que lo hacían las versiones predecesoras. Es por este motivo por el que se ha desarrollado esta nueva versión de congelador.

** Utilización del congelador

El *script* hay que ejecutarlo desde un usuario con permiso de administrador. Una vez descargado el *script*, hay que darle permiso de ejecución. Cuando se ejecuta en un *shell* o terminal la aplicación muestra las siguientes opciones de menú.
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






You can use the [editor on GitHub](https://github.com/juanluiscarrillo/Ofris-for-Mate/edit/main/docs/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [Basic writing and formatting syntax](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/juanluiscarrillo/Ofris-for-Mate/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.
