require 'byebug'
require 'part1'
require 'rspec'


describe Array do
    describe "#my_uniq" do
        it 'returns unique elements in the order they first appear' do
        expect([1,3,3,3,4,5,5,5,5,7,2,1,3,3].my_uniq).to eq([1,3,4,5,7,2])
        end
    end

    describe '#two_sum' do
        it 'includes all pairs of positions' do
            # debugger
            expect([-1, 0, 2, -2, 1].two_sum).to include([0, 4], [2,3])
        end

        it 'finds all pairs of positions where the elements at those positions sum to zero' do
            expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
        end
    end
end

describe "my_transpose" do
    it "transposes given a square matrix" do
        rows = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
          ]
        cols = [
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8]
          ]

          expect(my_transpose(rows)).to eq(cols)
    end
end