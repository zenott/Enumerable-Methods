require './enumerable.rb'

describe Enumerable do
  let(:test_array) { [1, 2, 3] }
  let(:test_hash) { { a: 1, b: 2, c: 3 } }
  let(:test_range) { (1..5) }
  let(:test_proc) { proc { |n| n * 2 } }

  describe '#my_each' do
    it 'outputs each element times 2 with Array' do
      expect { test_array.my_each { |n| print n * 2 } }.to output('246').to_stdout
    end

    it 'outputs each element times 2 with Range' do
      expect { test_range.my_each { |n| print n * 2 } }.to output('246810').to_stdout
    end

    it 'outputs each key and value times 2 with Hash' do
      expect { test_hash.my_each { |k, v| print "#{k}: #{2 * v}," } }.to output('a: 2,b: 4,c: 6,').to_stdout
    end
  end

  describe '#my_each_with_index' do
    it 'outputs each element and index with Array' do
      expect { test_array.my_each_with_index { |n, i| print "#{i}-#{n}," } }.to output('0-1,1-2,2-3,').to_stdout
    end

    it 'outputs each element and index with Range' do
      expect { test_range.my_each_with_index { |n, i| print "#{i}-#{n}," } }.to output('0-1,1-2,2-3,3-4,4-5,').to_stdout
    end

    it 'outputs each key-value pair and index with Hash' do
      expect { test_hash.my_each_with_index { |item, i| print "#{i}-#{item[0]}:#{item[1]}," } }.to output('0-a:1,1-b:2,2-c:3,').to_stdout
    end
  end

  describe '#my_select' do
    it 'returns odd numbers from Array' do
      expect(test_array.my_select(&:odd?)).to eq([1, 3])
    end

    it 'returns odd numbers from Range' do
      expect(test_range.my_select(&:odd?)).to eq([1, 3, 5])
    end

    it 'returns entries with odd values from Hash' do
      expect(test_hash.my_select { |_k, v| v.odd? }).to eq(a: 1, c: 3)
    end
  end

  describe '#my_all?' do
    it 'returns false if not all elements satisfy the condition' do
      expect(test_array.my_all? { |n| n > 1 }).to eq(false)
    end

    it 'returns true if all elements satisfy the condition' do
      expect(test_array.my_all? { |n| n < 10 }).to eq(true)
    end

    it 'returns false if not all elements satisfy the condition in Range' do
      expect(test_range.my_all? { |n| n > 1 }).to eq(false)
    end

    it 'returns true if all elements satisfy the condition in Range' do
      expect(test_range.my_all? { |n| n < 10 }).to eq(true)
    end

    it 'returns false if not all elements satisfy the condition in Hash' do
      expect(test_hash.my_all? { |_k, v| v > 1 }).to eq(false)
    end

    it 'returns true if all elements satisfy the condition in Hash' do
      expect(test_hash.my_all? { |_k, v| v < 10 }).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'returns false if none of the elements satisfy the condition' do
      expect(test_array.my_any? { |n| n > 10 }).to eq(false)
    end

    it 'returns true if at least one element satisfies the condition' do
      expect(test_array.my_any? { |n| n == 2 }).to eq(true)
    end

    it 'returns false if none of the elements satisfy the condition in Range' do
      expect(test_range.my_any? { |n| n > 10 }).to eq(false)
    end

    it 'returns true if at least one element satisfies the condition in Range' do
      expect(test_range.my_any? { |n| n == 2 }).to eq(true)
    end

    it 'returns false if none of the elements satisfy the condition in Hash' do
      expect(test_hash.my_any? { |_k, v| v > 10 }).to eq(false)
    end

    it 'returns true if at least one element satisfies the condition in Hash' do
      expect(test_hash.my_any? { |_k, v| v == 2 }).to eq(true)
    end
  end

  describe '#my_map?' do
    it 'returns Array with same elements' do
      expect(test_array.my_each { |n| n }).to match_array(test_array)
    end

    it 'returns modified array' do
      expect(test_array.my_map { |n| n * 2 }).to eq([2, 4, 6])
    end

    it 'returns modified array with Proc' do
      expect(test_array.my_map(test_proc)).to eq([2, 4, 6])
    end
  end
end
