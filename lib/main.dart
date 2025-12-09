import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

// Modèle de Question
class Question {
  String questionText;
  bool isCorrect;

  Question({required this.questionText, required this.isCorrect});
}

// Widget racine de l'application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Écran d'accueil
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône animée
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Titre
                const Text(
                  "Quiz Flutter",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Testez vos connaissances !",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 60),

                // Bouton Commencer
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizzPage(title: "Quiz Flutter"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6a11cb),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    "Commencer",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Page du Quiz (StatefulWidget)
class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> with SingleTickerProviderStateMixin {
  // Liste des questions
  final List<Question> _questions = [
    Question(questionText: "Flutter utilise le langage Dart", isCorrect: true),
    Question(questionText: "Un StatelessWidget peut changer d'état", isCorrect: false),
    Question(questionText: "setState() est utilisé pour mettre à jour l'UI", isCorrect: true),
    Question(questionText: "Flutter ne peut créer que des apps mobiles", isCorrect: false),
    Question(questionText: "Hot Reload permet de voir les changements instantanément", isCorrect: true),
    Question(questionText: "Un Widget est immuable", isCorrect: true),
    Question(questionText: "BuildContext représente la position du widget dans l'arbre", isCorrect: true),
    Question(questionText: "Flutter a été créé par Microsoft", isCorrect: false),
    Question(questionText: "MaterialApp est obligatoire dans toute app Flutter", isCorrect: false),
    Question(questionText: "Scaffold fournit la structure de base d'une page", isCorrect: true),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showFeedback = false;
  bool _isCorrectAnswer = false;
  bool _quizFinished = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Vérifier la réponse
  bool _checkAnswer(bool userChoice, BuildContext context) {
    bool correctAnswer = _questions[_currentQuestionIndex].isCorrect;
    bool isCorrect = userChoice == correctAnswer;

    setState(() {
      _showFeedback = true;
      _isCorrectAnswer = isCorrect;
      if (isCorrect) {
        _score++;
      }
    });

    // Animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Passer à la question suivante après 1.5 secondes
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _showFeedback = false;
        });
      } else {
        setState(() {
          _quizFinished = true;
        });
      }
    });

    return isCorrect;
  }

  // Question suivante
  Question _nextQuestion() {
    return _questions[_currentQuestionIndex];
  }

  // Recommencer le quiz
  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _showFeedback = false;
      _quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizFinished) {
      return _buildResultScreen();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec score et progression
              _buildHeader(),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Carte de question
                        _buildQuestionCard(),
                        const SizedBox(height: 40),

                        // Boutons Vrai/Faux
                        if (!_showFeedback) _buildAnswerButtons(),

                        // Feedback
                        if (_showFeedback) _buildFeedback(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header avec score
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton retour
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),

          // Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                Text(
                  "$_score / ${_questions.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Progression
          Text(
            "${_currentQuestionIndex + 1}/${_questions.length}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Carte de question
  Widget _buildQuestionCard() {
    return TweenAnimationBuilder(
      key: ValueKey(_currentQuestionIndex),
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icône de question
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6a11cb).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      size: 40,
                      color: Color(0xFF6a11cb),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Texte de la question
                  Text(
                    _nextQuestion().questionText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2d3436),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Boutons de réponse
  Widget _buildAnswerButtons() {
    return Column(
      children: [
        // Bouton VRAI
        _buildAnswerButton(
          label: "VRAI",
          color: const Color(0xFF00b894),
          icon: Icons.check_circle_outline,
          onPressed: () => _checkAnswer(true, context),
        ),
        const SizedBox(height: 20),

        // Bouton FAUX
        _buildAnswerButton(
          label: "FAUX",
          color: const Color(0xFFd63031),
          icon: Icons.cancel_outlined,
          onPressed: () => _checkAnswer(false, context),
        ),
      ],
    );
  }

  Widget _buildAnswerButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feedback de réponse
  Widget _buildFeedback() {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: _isCorrectAnswer
              ? const Color(0xFF00b894).withOpacity(0.2)
              : const Color(0xFFd63031).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isCorrectAnswer
                ? const Color(0xFF00b894)
                : const Color(0xFFd63031),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isCorrectAnswer ? Icons.check_circle : Icons.cancel,
              color: _isCorrectAnswer
                  ? const Color(0xFF00b894)
                  : const Color(0xFFd63031),
              size: 32,
            ),
            const SizedBox(width: 12),
            Text(
              _isCorrectAnswer ? "Correct !" : "Incorrect !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _isCorrectAnswer
                    ? const Color(0xFF00b894)
                    : const Color(0xFFd63031),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Écran de résultats
  Widget _buildResultScreen() {
    double percentage = (_score / _questions.length) * 100;
    String message;
    Color messageColor;
    IconData messageIcon;

    if (percentage >= 80) {
      message = "Excellent ! 🎉";
      messageColor = const Color(0xFF00b894);
      messageIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      message = "Bien joué ! 👍";
      messageColor = const Color(0xFF0984e3);
      messageIcon = Icons.thumb_up;
    } else {
      message = "Continuez à apprendre ! 💪";
      messageColor = const Color(0xFFfdcb6e);
      messageIcon = Icons.school;
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6a11cb), Color(0xFF2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icône de résultat
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      messageIcon,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Message
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Carte de résultats
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Votre Score",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2d3436),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Score circulaire
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CircularProgressIndicator(
                                value: _score / _questions.length,
                                strokeWidth: 12,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(messageColor),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "$_score",
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2d3436),
                                  ),
                                ),
                                Text(
                                  "/ ${_questions.length}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Text(
                          "${percentage.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: messageColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _restartQuiz,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6a11cb),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 8),
                            Text(
                              "Recommencer",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.home),
                            SizedBox(width: 8),
                            Text(
                              "Accueil",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}