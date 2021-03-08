require 'tower_of_hanoi'
require 'rspec'
require 'byebug'

describe Hanoi do
    subject(:game) {Hanoi.new}
    describe "#initialize" do
        it 'board makes three columns' do
            expect(game.board[0].length).to eq(3)
        end
    end

    describe '#populate_discs' do
        it 'makes 5 initial discs' do
            initial_setup = [
                [[1], [], []],
                [[2], [], []],
                [[3], [], []],
                [[4], [], []],
                [[5], [], []]
            ]
            game.populate_discs
            expect(game.board).to eq(initial_setup)
        end
    end

    describe '#valid_pos?(pos)' do
        it 'raises error if row is not between 1 and 5' do
            expect {game.valid_pos?([6,1])}.to raise_error "Not a valid position"
        end

        it 'raises error if col is not between 1 and 3' do
            expect {game.valid_pos?([1,5])}.to raise_error "Not a valid position"
        end
    end

    describe '#move' do
        it 'moves a disc' do
            moved = [
                [[], [], []],
                [[2], [], []],
                [[3], [], []],
                [[4], [], []],
                [[5], [1], []]
            ]
            game.populate_discs
            game.move([0,0], [4,1])
            expect(game.board).to eq(moved)
        end

        it 'raises error if try to move into place where disc already exist' do
            game.populate_discs
            game.move([0,0], [4,1])
            expect {game.move([1, 0], [4,1])}.to raise_error "Invalid move"
        end

        it 'raises error if try to move a piece that is in between other pieces' do
            game.populate_discs
            expect {game.move([1, 0], [4,1])}.to raise_error "Invalid move"
        end

        it 'raises error if try to move bigger disc on top of smaller disc' do
            game.populate_discs
            game.move([0,0], [4,1])
            expect {game.move([1, 0], [3,1])}.to raise_error "Invalid move"
        end
    end

    describe 'won?' do
        it 'return true if board is at winning state' do
            win_game = Hanoi.new(board = [
                [[], [], [1]],
                [[], [], [2]],
                [[], [], [3]],
                [[], [], [4]],
                [[], [], [5]]
            ])
            expect(win_game.won?).to be true
        end

        it 'returns false if board is not at winning state' do
            expect(game.won?).to be false
        end
    end

end