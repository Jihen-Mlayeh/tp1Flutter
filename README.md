# 🧠 Quiz App - Flutter Application

## 📋 Description

**Quiz App** est une application Flutter interactive qui permet aux utilisateurs de tester leurs connaissances sur Flutter et Dart à travers un questionnaire dynamique. Cette application démontre l'utilisation des **StatefulWidgets** pour gérer l'état et créer des expériences utilisateur interactives avec animations.

## ✨ Fonctionnalités

- 🎯 **Quiz Interactif** : 10 questions Vrai/Faux sur Flutter et Dart
- 🏠 **Écran d'Accueil Animé** : Interface d'entrée attractive avec animations
- ✅ **Feedback Immédiat** : Indication instantanée des bonnes/mauvaises réponses
- 📊 **Score en Temps Réel** : Suivi du score pendant le quiz
- 🎨 **Animations Fluides** : Transitions élégantes entre les questions
- 📈 **Indicateur de Progression** : Affichage de la question actuelle (X/10)
- 🎊 **Écran de Résultats** : Statistiques détaillées avec score circulaire
- 🔄 **Recommencer le Quiz** : Possibilité de rejouer indéfiniment
- 🎨 **Design Moderne** : Interface avec gradients et effets visuels

## 🏗️ Architecture

### Structure des Widgets

```
MaterialApp
├── WelcomeScreen (StatelessWidget)
│   └── Scaffold
│       └── Bouton "Commencer"
│
└── QuizzPage (StatefulWidget)
    ├── _QuizzPageState (State)
    │   ├── Variables d'état
    │   │   ├── _currentQuestionIndex: int
    │   │   ├── _score: int
    │   │   ├── _showFeedback: bool
    │   │   ├── _isCorrectAnswer: bool
    │   │   ├── _quizFinished: bool
    │   │   └── _questions: List<Question>
    │   │
    │   └── Méthodes
    │       ├── _checkAnswer()
    │       ├── _nextQuestion()
    │       ├── _restartQuiz()
    │       ├── _buildQuestionCard()
    │       ├── _buildAnswerButtons()
    │       ├── _buildFeedback()
    │       └── _buildResultScreen()
    │
    └── Écrans
        ├── Quiz (questions + boutons)
        └── Résultats (score + statistiques)
```

## 📁 Structure du Projet

```
quiz_app_flutter/
├── lib/
│   └── main.dart              # Code principal de l'application
├── android/                   # Configuration Android
├── ios/                       # Configuration iOS
├── web/                       # Configuration Web
├── pubspec.yaml               # Dépendances et assets
├── README.md                  # Ce fichier
└── screenshots/               # Captures d'écran
    ├── welcome_screen.png
    ├── quiz_question.png
    ├── quiz_feedback.png
    └── quiz_results.png
```

## 🎓 Concepts Flutter Utilisés

### StatefulWidget

Cette application utilise des **StatefulWidgets** car :
- L'état change en fonction des interactions utilisateur
- Nécessité de reconstruire l'UI après chaque réponse
- Gestion de multiples états (question active, feedback, résultats)
- Utilisation de `setState()` pour mettre à jour l'interface

### Gestion d'État

#### Variables d'État Principales

| Variable | Type | Description |
|----------|------|-------------|
| `_currentQuestionIndex` | `int` | Index de la question actuelle (0-9) |
| `_score` | `int` | Nombre de bonnes réponses |
| `_showFeedback` | `bool` | Afficher ou non le feedback |
| `_isCorrectAnswer` | `bool` | État de la dernière réponse |
| `_quizFinished` | `bool` | Le quiz est-il terminé ? |
| `_questions` | `List<Question>` | Liste des questions |

#### Cycle de Vie du State

```dart
initState()  →  build()  →  User Action  →  setState()  →  build()
                    ↑                                        ↓
                    └────────────────────────────────────────┘
```



## 🎯 Workflow de l'Application

```
┌─────────────────┐
│  Écran d'Accueil│
└────────┬────────┘
         │ Clic "Commencer"
         ↓
┌─────────────────┐
│  Afficher       │
│  Question 1/10  │
└────────┬────────┘
         │ Clic Vrai/Faux
         ↓
┌─────────────────┐
│  Vérifier       │
│  Réponse        │
└────────┬────────┘
         │
    ┌────┴────┐
    │ Correct?│
    └────┬────┘
    ↙         ↘
 OUI           NON
  │             │
  ↓             ↓
Score++      Score
  │             │
  └──────┬──────┘
         │ Afficher Feedback
         ↓
┌─────────────────┐
│ Dernière        │
│ Question?       │
└────────┬────────┘
    ┌────┴────┐
 OUI         NON
  │           │
  ↓           ↓
┌──────┐  ┌────────┐
│Résul-│  │Question│
│ tats │  │Suivante│
└──────┘  └───┬────┘
              │
              ↑──────┘


## 📊 Statistiques de l'Application

- **10 Questions** sur Flutter et Dart
- **Score Maximum** : 10/10
- **Temps Moyen** : 2-3 minutes
- **3 Écrans** : Accueil, Quiz, Résultats

## 📚 Questions du Quiz

1. Flutter utilise le langage Dart ✅
2. Un StatelessWidget peut changer d'état ❌
3. setState() est utilisé pour mettre à jour l'UI ✅
4. Flutter ne peut créer que des apps mobiles ❌
5. Hot Reload permet de voir les changements instantanément ✅
6. Un Widget est immuable ✅
7. BuildContext représente la position du widget dans l'arbre ✅
8. Flutter a été créé par Microsoft ❌
9. MaterialApp est obligatoire dans toute app Flutter ❌
10. Scaffold fournit la structure de base d'une page ✅


## 👨‍💻 Auteur

**Votre Nom**
- Email: mlayehjihen@gmailcom
- ## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/NouvelleFonctionnalite`)
3. Commit vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/NouvelleFonctionnalite`)
5. Ouvrez une Pull Request



