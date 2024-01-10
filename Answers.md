# Answers

## Exercice 1
### Le target :
Le target permet de spécifier un point d'entrée de l’application.

### Les fichiers :

#### AppDelegate.swift :
Le fichier AppDelegate est une classe qui implémente le protocole UIApplicationDelegate. Il gère les événements du cycle de vie de l'application. La ligne “@main” permette indique au système qu’il va se servir des fonctions présentes dans cette class.

#### SceneDelegate.swift :
La classe SceneDelegate permet la gestion des fenêtres et des scènes. Elle permet de mieux prendre en charge les multiples fenêtres sur iPad et la prise en charge des interfaces utilisateur multiples. SceneDelegate gère la configuration initiale de l'interface utilisateur de l'application, notamment la fenêtre principale.

#### ViewController.swift :
Le fichier ViewController est généralement associé à une vue spécifique dans votre application. Il contient la logique métier liée à cette vue. 

#### Main.storyboard :
Le fichier Main.storyboard est un fichier de format XML qui permet de modifier l'interface principal de votre application. Vous pouvez définir la structure de votre interface utilisateur et les transitions entre les différentes vues.

#### Assets.xcassets :
Le fichier assets est la librairie principale d’image de votre application. il est utilisé pour stocker diverses ressources graphiques, telles que des images, des icônes et des launch images.

#### LaunchScreen.storyboard :
Comme tous les fichiers storyboard, ce fichier de format XML permet de modifier l'interface de votre application.
Le fichier LaunchScreen.storyboard est utilisé pour créer une interface utilisateur simple qui apparaît pendant le lancement de l'application. Il sert généralement d'écran de lancement ou d'écran de bienvenue.

### Les assets :
Les fichiers d'assets, tels que les images, sont généralement ajoutés à votre projet en les glissant-déposant dans le dossier "Assets.xcassets". Cela crée un catalogue d'images géré par Xcode.


### Ouvrir le Storyboard :
Les storyboards sont l'interface visuelle de votre application. En double-cliquer sur le fichier avec l'extension ".storyboard" dans l'arborescence du projet pour ouvrir l’éditeur.

### Ouvrir un Simulateur :
Le simulateur permet de tester le code.
Pour ouvrir le simulateur iOS, sélectioner un simulateur dans la barre d'outils en haut de Xcode. Si aucun simulateur n'est ouvert, ajouter un en allant dans "Xcode" > "Outils pour les développeurs" > "Simulateurs iOS".

### Lancer une Application sur le Simulateur :
Pour lancer un application sur le simulateur:
    - Sélectionner le simulateur dans la barre d'outils. 
    - Cliquer ensuite sur le bouton play.

## Exercice 2:

### A quoi sert le raccourci Cmd + R ?
Cmd + R est un racourci clavier permettant de lance la compliation en mode simultation sur sur le simulateur ou sur un appareil connecté.

### A quoi sert le raccourci Cmd + Shift + O ?
Le racourci clavier Cmd + Shift + O permet d'ouvrir la barre de recherche "Open Quickly". Cette barre de rechercher permet de faire une recherche dans tous le code du projet. (équivalent à ```cmd + shift + F``` et à ```cmd + shift + N``` sur PHPstorm).

### Trouver le raccourci pour indenter le code automatiquement
Le racourci clavier pour indenter le code selectionné automatiquement est ```Ctrl + I```.

### Trouver le raccourci pour commenter la selection.
Le racourci clavier pour indenter le code selectionné automatiquement est ```Cmd + /```.

## Exercice 4

### Que venons nous de faire en réalité ? Quel est le rôle du NavigationController ?
Nous venons de créé une structure de navigation. NavigationController nous permet d'organiser nos vus.

### Est-ce que la NavigationBar est la même chose que le NavigationController ?

NavigationController s'occupe d'integer une NavigationBar pour chaque vue qu'il gère. NavigationController s'occupe de la navigation entre les vues et NavigationBar afficher les données de navigation spécifiques à chaque vue.

## Créer l’écran de détail

### Exercice 1
Expliquer ce qu’est un Segue et à quoi il sert.  
Un Segue est une transition, il permet de créer une transition entre deux vues. il permet de spécifier l'annimation mais aussi comment les données se transfaire.

### Exercice 2
Qu’est-ce qu’une constraint ? A quoi sert-elle ? Quel est le lien avec AutoLayout ?  
Une contraint est une règle, permet de définir la disposition des éléments sur une interface utilisateur.
Une constraint permet à AutoLayout d'adapter l'interface en fonction de l'écran et de l'pareil utilisé.

## 9-qlpreview

### Pourquoi serait-il plus pertinent de changer l’accessory de nos cellules pour un disclosureIndicator ?
Les utiliateurs sont abitués à voir c'est élément. En changant l'accessory par disclosureIndicator nous améliorons l'expérience utilisateur de notre application. 

## 10-importation

### Expliquez ce qu’est un #selector en Swift
Un #selector permet de faire appel à une méthode, fonction ou propriété spécifique.

### Que représente .add dans notre appel ?
.add permet d'afficher la bouton avec un plus pour indiquer à l'utilisateur qu'il peut ajouter un élément.

### Expliquez également pourquoi XCode vous demande de mettre le mot clé @objc devant la fonction ciblée par le #selector
La fonction ciblée par #selector nécessite Objective-C au runtime. Il est donc important de spécifier @objc.

### Peut-on ajouter plusieurs boutons dans la barre de navigation ? Si oui, comment en code ?
    Oui on peut ajouter des boutons à la barre de navigation d'un UIViewController. On le faire en créant un tableau de UIBarButtonItem et en les assignant à la propriété rightBarButtonItems ou/et leftBarButtonItems de la propriété navigationItem.

### A quoi sert la fonction defer ?
La fonction defer permet de garantir l'exécution du code malgré une lever d'erreur survenue par la suite.



