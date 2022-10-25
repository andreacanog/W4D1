require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @alternative_mark = @next_mover_mark == :x ? :o : :x
  end

  def losing_node?(evaluator)
    #debugger
    return false if @board.over? && (evaluator == @board.winner || @board.winner == nil)
    return true if @board.over? && evaluator != @board.winner
    if evaluator == @next_mover_mark
      self.children.all? {|child| child.losing_node?(evaluator)}
    else
      self.children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if @board.empty?([i,j])
          b = @board.dup
          b[[i, j]] = @next_mover_mark
          if @next_mover_mark == :x
            mark = :o
          else
            mark = :x
          end
          children<<TicTacToeNode.new(b,mark,[i,j])
        end
      end
    end
    children
  end
    
end
