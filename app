# Medical Detective Game - File Structure & Setup Guide

## 📁 Complete Project Structure

```
medical-detective-game/
├── README.md                    # Project documentation
├── package.json                 # Node.js dependencies (optional)
├── .gitignore                   # Git ignore file
│
├── public/                      # Static files served by web server
│   ├── index.html              # Main landing page
│   ├── game.html               # Main game interface
│   ├── leaderboard.html        # High scores page
│   │
│   ├── css/
│   │   ├── style.css           # Main stylesheet
│   │   ├── game.css            # Game-specific styles
│   │   └── animations.css      # Animation effects
│   │
│   ├── js/
│   │   ├── main.js             # Game initialization & flow
│   │   ├── cases.js            # Patient case data
│   │   ├── diagnosis.js        # Diagnosis logic
│   │   ├── ui.js               # UI updates & interactions
│   │   └── scoring.js          # Score calculation
│   │
│   ├── images/
│   │   ├── logo.png
│   │   ├── patient-icons/      # Patient avatars
│   │   ├── medical-tools/      # Stethoscope, clipboard, etc.
│   │   └── backgrounds/        # Game backgrounds
│   │
│   └── sounds/                  # Optional audio
│       ├── correct.mp3
│       ├── wrong.mp3
│       └── click.mp3
│
├── server/                      # Backend (optional - for leaderboard)
│   ├── server.js               # Express server
│   ├── routes/
│   │   └── scores.js           # Leaderboard API
│   └── data/
│       └── scores.json         # Score storage
│
└── docs/
    ├── DESIGN.md               # Game design document
    ├── DEPLOYMENT.md           # Render deployment guide
    └── DEVELOPMENT.md          # Development notes
```

---

## 🎮 Game Flow Architecture

```
Landing Page (index.html)
    ↓
    [Start Game Button]
    ↓
Game Page (game.html)
    ↓
    ┌─────────────────────────────┐
    │  1. Patient Arrives         │
    │     - Show symptoms         │
    │     - Display patient info  │
    └─────────────────────────────┘
    ↓
    ┌─────────────────────────────┐
    │  2. Interview Phase         │
    │     - Ask questions         │
    │     - Gather clues          │
    └─────────────────────────────┘
    ↓
    ┌─────────────────────────────┐
    │  3. Testing Phase           │
    │     - Order tests           │
    │     - View results          │
    │     - Costs time/points     │
    └─────────────────────────────┘
    ↓
    ┌─────────────────────────────┐
    │  4. Diagnosis Phase         │
    │     - Select diagnosis      │
    │     - Submit answer         │
    └─────────────────────────────┘
    ↓
    ┌─────────────────────────────┐
    │  5. Results                 │
    │     - Correct/Incorrect     │
    │     - Score update          │
    │     - Explanation           │
    └─────────────────────────────┘
    ↓
    [Next Patient] or [End Game]
    ↓
Leaderboard Page (leaderboard.html)
```

---

## 📋 Core Game Data Structure

### Patient Case Object (cases.js)
```javascript
const case = {
  id: 1,
  patientName: "John Smith",
  age: 45,
  gender: "Male",
  
  // Initial presentation
  chiefComplaint: "Severe chest pain",
  initialSymptoms: ["Chest pain", "Shortness of breath", "Sweating"],
  
  // Interview questions & answers
  questions: [
    {
      id: 1,
      question: "When did the pain start?",
      answer: "About 2 hours ago",
      relevance: "high" // Helps narrow diagnosis
    },
    {
      id: 2,
      question: "Does the pain radiate anywhere?",
      answer: "Down my left arm",
      relevance: "critical" // Key clue
    }
  ],
  
  // Available tests
  availableTests: [
    {
      id: "ecg",
      name: "ECG (Electrocardiogram)",
      cost: 50, // Points cost
      timeCost: 30, // Seconds
      result: "ST-segment elevation detected",
      relevant: true
    },
    {
      id: "bloodwork",
      name: "Complete Blood Count",
      cost: 30,
      timeCost: 60,
      result: "Normal white blood cell count",
      relevant: false
    }
  ],
  
  // Possible diagnoses
  possibleDiagnoses: [
    "Heart Attack (MI)",
    "Angina",
    "Gastric Reflux",
    "Panic Attack",
    "Pneumonia"
  ],
  
  // Correct answer
  correctDiagnosis: "Heart Attack (MI)",
  
  // Explanation
  explanation: "The combination of chest pain radiating to left arm, sweating, and ST-elevation on ECG indicates myocardial infarction (heart attack). Immediate treatment is critical.",
  
  // Difficulty
  difficulty: "medium"
};
```

---

## 🎯 Scoring System

```javascript
const scoringRules = {
  basePoints: 1000,
  
  // Deductions
  wrongQuestion: -10,      // Asked irrelevant question
  unnecessaryTest: -50,    // Ordered test that wasn't needed
  wrongDiagnosis: -500,    // Incorrect diagnosis
  timeOver: -100,          // Took too long
  
  // Bonuses
  correctFirstTry: +200,   // Got it right without mistakes
  efficientTests: +100,    // Only ordered necessary tests
  fastDiagnosis: +150,     // Completed quickly
  
  // Time limits
  maxTimeSeconds: 300      // 5 minutes per case
};
```

---

## 🚀 Quick Start Commands

### For Simple Static Site (No Backend):
```bash
# Just open index.html in browser
# Or use Python simple server:
python -m http.server 8000
```

### For Full Stack (With Leaderboard):
```bash
# Initialize project
npm init -y

# Install dependencies
npm install express cors

# Create server.js
# Run server
node server/server.js

# Visit http://localhost:3000
```

---

## 📦 Minimal package.json (if using backend)

```json
{
  "name": "medical-detective-game",
  "version": "1.0.0",
  "description": "A medical diagnosis game",
  "main": "server/server.js",
  "scripts": {
    "start": "node server/server.js",
    "dev": "nodemon server/server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
```

---

## 📝 .gitignore

```
# Dependencies
node_modules/
package-lock.json

# Environment
.env
.env.local

# Build
dist/
build/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*

# Data
server/data/*.json
!server/data/scores-example.json
```

---

## 🎨 Feature Checklist

### MVP (Minimum Viable Product) - Week 1
- [ ] Landing page with game title & start button
- [ ] 3 patient cases loaded from data
- [ ] Display patient symptoms
- [ ] Interview phase (click questions to reveal answers)
- [ ] Multiple choice diagnosis selection
- [ ] Correct/incorrect feedback
- [ ] Basic scoring
- [ ] Responsive CSS

### Enhanced Features - Week 2
- [ ] Testing phase (order lab tests)
- [ ] Timer countdown
- [ ] Score breakdown display
- [ ] Multiple difficulty levels
- [ ] Case progression (unlock harder cases)
- [ ] Visual polish & animations
- [ ] Sound effects

### Advanced Features - Week 3 (Optional)
- [ ] Leaderboard with backend
- [ ] User accounts / name entry
- [ ] Save/resume game progress
- [ ] Achievement badges
- [ ] Random case generation
- [ ] Hint system

---

## 🎓 Educational Value (For Project Report)

**Computer Science Concepts Demonstrated:**
1. **Data Structures** - Complex nested objects for patient cases
2. **Algorithms** - Scoring logic, decision trees
3. **State Management** - Game state tracking
4. **Event Handling** - User interactions
5. **Conditional Logic** - Diagnosis validation
6. **API Design** - Backend endpoints (if included)
7. **DOM Manipulation** - Dynamic UI updates
8. **Responsive Design** - Cross-device compatibility

---

## 📊 Game Metrics to Track

```javascript
const gameMetrics = {
  casesCompleted: 0,
  totalScore: 0,
  averageTime: 0,
  accuracy: 0, // Percentage of correct diagnoses
  testsOrdered: 0,
  questionsAsked: 0,
  hintsUsed: 0
};
```

---

## 🎬 Next Steps

1. **Create the folder structure** as shown above
2. **I'll build the core game files** for you in separate artifacts
3. **Test locally** in browser
4. **Deploy to Render** when ready
5. **Document the process** for her project report

Would you like me to create:
1. The complete HTML/CSS/JS game code?
2. Sample patient case data?
3. Render deployment guide?
4. All of the above?

Let me know and I'll build the working game for her! 🚀
