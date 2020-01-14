# Find My Game

« Find my game » est une application iOS pour iPhone permettant de faire découvrir des jeux vidéo aux néophytes comme aux connaisseurs par le biais de questionnaires.
Cette application a pour but de mettre en avant certaines catégories de jeux et de faciliter vos recherches.

## Architecture

- L’application est basée sur l’API IGDB (Internet Game DataBase)
- Les appels réseaux sont passés avec URLSession et le type Result()
- La récupération et le cache des images (covers, screenshots) sont gérés par le POD SDWebImage
- Les favoris (persistance des données) sont gérés par CoreData.
- Utilisation de ScrollView, CollectionView, TableView, VisualEffect (Blur, Vibrancy) dans le StoryBoard avec AutoLayout.

Find my game a été écrit sous Xcode 11 en Swift 5 selon le pattern de conception MVC et supporte les iPhones en mode portrait à partir de iOS11

## Description

L’onglet « Find » comprend :

-	un questionnaire s’apparentant à un test de personnalité vous proposant des jeux dont le genre ou le thème pourrait vous plaire ;
-	un questionnaire mettant l’accent sur l’aspect Multi-Joueur en local vous permettant de trouver rapidement des jeux en fonction du nombre de joueurs pour animer vos soirées ;
-	une rubrique présentant les meilleurs jeux de rythme ou de musique ;
-	une rubrique présentant les indispensables de le Réalité Virtuelle.
 
L’onglet « Search » permet la recherche d’un jeu d’une manière plus classique (barre et filtres de recherche).

L’onglet « Favorite » permet de voir les jeux qui ont été sauvegardés, pour chaque résultat les jeux peuvent être mis en favoris.

## Pour commencer

### Pré-requis

Créez un compte gratuit pour l'accès à l'API IGDB
https://api.igdb.com/

### Installation

Après avoir téléchargé le projet, ouvrez P12Workspace.xcworkspace
Dans le dossier "P12" créez un fichier .swift contenant la classe "ApiKeys", dans cette classe créez la variable statique "igdbApiKey" contenant votre clé (type String)

```swift
final class ApiKeys {
    static var igdbApiKey = "yourIGDBApiKey"
}
```
