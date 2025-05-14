import 'dart:io';

void main() {
  bool continuePlaying = true;
  
  while (continuePlaying) {
    startGame();
    continuePlaying = askToPlayAgain();
  }
}

void startGame() {
  List<String> grid = List.filled(9, ' ');
  String playerTurn = 'X';
  int moveCount = 0;

  while (true) {
    display(grid);
    int move = getPlayerInput(playerTurn);

    if (grid[move] != ' ') {
      print('المربع مشغول، حاول من فضلك مرة أخرى.');
      continue;
    }

    grid[move] = playerTurn;
    moveCount++;

    if (theWinner(grid, playerTurn)) {
      display(grid);
      print('اللاعب $playerTurn فاز!');
      break;
    }

    if (moveCount == 9) {
      display(grid);
      print('اللعبة تعادلت!');
      break;
    }

    playerTurn = (playerTurn == 'X') ? 'O' : 'X';
  }
}

void display(List<String> board) {
  print('اللوحة الحالية:');
  for (int i = 0; i < 3; i++) {
    print('${board[i * 3]} | ${board[i * 3 + 1]} | ${board[i * 3 + 2]}');
    if (i < 2) print('---------');
  }
}

int getPlayerInput(String player) {
  while (true) {
    print('اللاعب $player، أدخل رقم الحركة (1-9):');
    String? input = stdin.readLineSync();
    int? move = int.tryParse(input ?? '');
    if (move != null && move >= 1 && move <= 9) {
      return move - 1;
    }
    print('إدخال غير صحيح! يرجى إدخال رقم بين 1 و 9.');
  }
}

bool theWinner(List<String> board, String player) {
  List<List<int>> winningPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pattern in winningPatterns) {
    if (board[pattern[0]] == player &&
        board[pattern[1]] == player &&
        board[pattern[2]] == player) {
      return true;
    }
  }
  return false;
}

bool askToPlayAgain() {
  print('هل تريد اللعب مرة أخرى؟ (y/n)');
  String? response = stdin.readLineSync();
  return response?.toLowerCase() == 'y';
}