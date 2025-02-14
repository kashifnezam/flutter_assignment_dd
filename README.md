# Flutter Savings Manager App

## Overview
This is a **Flutter mobile application** that allows users to manage their savings by dividing them into two components: **CompA** and **CompB**. Users can add savings, withdraw money, and view their transaction history. The app is built using **Clean Architecture** and **GetX** for state management, with **SharedPreferences** for local data persistence.

---

## Features
1. **Splash Screen**:
   - Displays a welcome message for 2 seconds before navigating to the main screen.

2. **User Name Setup**:
   - Asks for the user's name if it’s their first time using the app.
   - Allows users to reset their name in the **Settings Screen**.

3. **Main Screen**:
   - Displays the current balance of **CompA** and **CompB**.
   - Shows a **pie chart** for savings distribution.
   - Provides **quick actions** for adding savings and withdrawing money.
   - Displays **recent transactions** and a button to view the complete history.

4. **Add Savings Screen**:
   - Allows users to input their annual savings.
   - Splits the savings equally between **CompA** and **CompB**.

5. **Withdraw Screen**:
   - Allows users to withdraw money from either **CompA** or **CompB**.
   - Shows the current balance of the selected component.

6. **History Screen**:
   - Displays all transactions with **date**, **time**, **type**, and **amount**.
   - Includes a **bar chart** for visualizing savings over time.

7. **Settings Screen**:
   - Allows users to reset their name.



## Technologies Used
- **Flutter**: For building the cross-platform mobile app.
- **GetX**: For state management and navigation.
- **SharedPreferences**: For local data persistence.
- **fl_chart**: For displaying charts (pie chart, bar chart).
- **Clean Architecture**: For organizing the code into layers (core, data, domain, presentation).

---

## How to Run the App
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/kashifnezam/flutter_assignment_dd
   cd flutter_assignment_dd