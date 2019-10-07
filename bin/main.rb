puts "Hello World\n\n"

BOARD_COLS = 3
BOARD_ROWS = 3
$Board = []

class String
  def gray
    "\e[38m#{self}\e[0m" 
  end
  def red
     "\e[31m#{self}\e[0m" 
  end
  def green
    "\e[32m#{self}\e[0m"
  end
  def blue
    "\e[34m#{self}\e[0m"
  end
end

def initializeBoard
  for i in 1..BOARD_COLS*BOARD_ROWS
    $Board << i
  end
end

initializeBoard()

def displayBoard
  for i in 0..(BOARD_COLS*BOARD_ROWS)+((BOARD_ROWS-1)*BOARD_COLS)-1
      if i < 3
        print " #{$Board[i]}" unless i == 2
        print " |" unless i == 2
        print " #{$Board[i]}" if i == 2
      elsif i < 6 && i > 2
        if i == 3
          puts ""
        end
        print "----"
      elsif i < 9 && i > 5
        if i == 6
          puts ""
        end
        print " #{$Board[i-3]} |" unless i == 8
        print " #{$Board[i-3]}" if i == 8
      elsif i < 12 && i > 8
        if i == 9
          puts ""
        end
        print "----"
      elsif i < 15 && i > 11
        if i == 12
          puts ""
        end
        print " #{$Board[i-6]} |" unless i == 14
        print " #{$Board[i-6]}" if i == 14
      end
    end
    puts "\n \n"
end

def posToBoard(pos, sym, color)
  $Board[pos] = "#{sym}".green if color == "green"
  $Board[pos] = "#{sym}".red if color == "red"
  $Board[pos] = "#{sym}".blue if color == "blue"
  displayBoard()
end

posToBoard(1,"X", "red")
