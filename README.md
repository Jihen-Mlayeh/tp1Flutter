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

### Modèle de Données

```dart
class Question {
  String questionText;  // Texte de la question
  bool isCorrect;       // Réponse correcte (true ou false)
  
  Question({
    required this.questionText,
    required this.isCorrect
  });
}
```

## 🚀 Installation

### Prérequis

- Flutter SDK (3.10.1 ou supérieur)
- Dart SDK (3.0 ou supérieur)
- Un éditeur (VS Code, Android Studio, IntelliJ IDEA)
- Un émulateur ou un appareil physique

### Étapes d'Installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/votre-username/quiz-app-flutter.git
   cd quiz-app-flutter
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   flutter run
   ```

## ⚙️ Configuration

### Ajouter/Modifier des Questions

Modifiez la liste `_questions` dans `lib/main.dart` :

```dart
final List<Question> _questions = [
  Question(
    questionText: "Votre question ici ?",
    isCorrect: true  // ou false
  ),
  Question(
    questionText: "Une autre question ?",
    isCorrect: false
  ),
  // Ajoutez autant de questions que nécessaire
];
```

### Personnalisation des Couleurs

Modifiez les gradients dans le code :

```dart
// Gradient principal
gradient: LinearGradient(
  colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
),

// Couleur bouton VRAI
color: const Color(0xFF00b894),

// Couleur bouton FAUX
color: const Color(0xFFd63031),
```

### Ajuster la Durée du Feedback

Modifiez le délai dans `_checkAnswer()` :

```dart
Future.delayed(const Duration(milliseconds: 1500), () {
  // 1500ms = 1.5 secondes
  // Changez cette valeur pour ajuster le timing
});
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

### Animations

L'application utilise plusieurs types d'animations :

1. **TweenAnimationBuilder** : Animations d'entrée des cartes
   ```dart
   TweenAnimationBuilder(
     tween: Tween<double>(begin: 0, end: 1),
     duration: const Duration(milliseconds: 500),
     builder: (context, double value, child) {
       return Transform.scale(scale: value, child: child);
     }
   )
   ```

2. **ScaleTransition** : Animation élastique du feedback
   ```dart
   ScaleTransition(
     scale: CurvedAnimation(
       parent: _animationController,
       curve: Curves.elasticOut,
     ),
     child: feedbackWidget,
   )
   ```

3. **AnimationController** : Contrôle des animations personnalisées

### Navigation

Navigation entre écrans avec Flutter Navigator :

```dart
// Vers l'écran de quiz
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => QuizzPage()),
);

// Retour à l'écran précédent
Navigator.pop(context);
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
```

## 🔧 Fonctions Clés

### Vérification de Réponse

```dart
bool _checkAnswer(bool userChoice, BuildContext context) {
  // 1. Récupérer la réponse correcte
  bool correctAnswer = _questions[_currentQuestionIndex].isCorrect;
  
  // 2. Comparer avec le choix de l'utilisateur
  bool isCorrect = userChoice == correctAnswer;
  
  // 3. Mettre à jour l'état
  setState(() {
    _showFeedback = true;
    _isCorrectAnswer = isCorrect;
    if (isCorrect) _score++;
  });
  
  // 4. Passer à la question suivante après 1.5s
  Future.delayed(Duration(milliseconds: 1500), () {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showFeedback = false;
      });
    } else {
      setState(() { _quizFinished = true; });
    }
  });
  
  return isCorrect;
}
```

### Recommencer le Quiz

```dart
void _restartQuiz() {
  setState(() {
    _currentQuestionIndex = 0;
    _score = 0;
    _showFeedback = false;
    _quizFinished = false;
  });
}
```

## 🎨 Choix de Design

### Palette de Couleurs

- **Primaire** : Violet/Bleu (#6a11cb - #2575fc)
- **Succès** : Vert (#00b894)
- **Erreur** : Rouge (#d63031)
- **Accent** : Blanc pour les cartes
- **Texte** : Gris foncé (#2d3436)

### Principes de Design

1. **Feedback Visuel Immédiat** : Couleurs différentes pour correct/incorrect
2. **Hiérarchie Visuelle** : Mise en évidence des éléments importants
3. **Animations Subtiles** : Améliorer l'expérience sans distraire
4. **Espacement Généreux** : Interface aérée et lisible
5. **Consistance** : Même style sur tous les écrans

## 🔧 Dépannage

### Problème : setState() appelé après dispose()

**Solution :** Vérifiez que vous n'appelez pas setState() après avoir quitté l'écran.

```dart
@override
void dispose() {
  _animationController.dispose();
  super.dispose();
}
```

### Problème : Animations saccadées

**Solution :** Optimisez les rebuild avec `const` constructors :

```dart
const Text("Mon texte")  // Au lieu de Text("Mon texte")
```

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

## 🚀 Améliorations Futures

### Version 2.0 (Planifiée)

- [ ] **Catégories de questions** (Flutter, Dart, Design, Performance)
- [ ] **Niveaux de difficulté** (Facile, Moyen, Difficile)
- [ ] **Chronomètre** pour limiter le temps de réponse
- [ ] **Meilleurs scores** sauvegardés avec SharedPreferences
- [ ] **Questions à choix multiples** (4 options)
- [ ] **Effets sonores** pour le feedback
- [ ] **Mode multijoueur** local
- [ ] **Partage de score** sur les réseaux sociaux
- [ ] **Thèmes personnalisables** (clair/sombre)
- [ ] **Base de données** de questions dynamique

## 📚 Ressources

### Documentation
- [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)
- [Animations](https://flutter.dev/docs/development/ui/animations)
- [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html)

### Tutoriels
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Building Layouts](https://flutter.dev/docs/development/ui/layout)
- [Adding Interactivity](https://flutter.dev/docs/development/ui/interactive)

## 👨‍💻 Auteur

**Votre Nom**
- GitHub: [@votre-username](https://github.com/votre-username)
- Email: votre.email@example.com

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/NouvelleFonctionnalite`)
3. Commit vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/NouvelleFonctionnalite`)
5. Ouvrez une Pull Request

### Guidelines de Contribution

- Respectez le style de code existant
- Ajoutez des tests pour les nouvelles fonctionnalités
- Mettez à jour la documentation
- Testez sur plusieurs plateformes (iOS, Android, Web)

## 📝 Changelog

### Version 1.0.0 (Date actuelle)
- ✅ Implémentation du quiz de base avec 10 questions
- ✅ Écran d'accueil avec animations
- ✅ Feedback immédiat après chaque réponse
- ✅ Score en temps réel
- ✅ Écran de résultats avec statistiques
- ✅ Animations fluides entre les transitions
- ✅ Design moderne avec gradients

## 🙏 Remerciements

- L'équipe Flutter pour cet excellent framework
- La communauté Flutter pour les ressources et l'inspiration
- Les contributeurs du projet

---

⭐ Si ce projet vous a aidé, n'hésitez pas à lui donner une étoile !

💬 Des questions ? Ouvrez une issue sur GitHub !
