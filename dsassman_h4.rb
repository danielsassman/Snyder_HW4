
#Uses memoization to save intial returns in hash table so once it computes the fib once it can use 
#the hash table to retrieve the element next time
def fib(n, cacheMemo = {})
  if n == 0 || n == 1
    return n
  end
  cacheMemo[n] ||= fib(n-1, cacheMemo) + fib(n-2, cacheMemo)
end

#given a list of values, create a new list with the same values in reversed order. 
#Do not modify the original list.
def reversed(xs)
        listLength = xs.length-1
        newList = []
        while(listLength>=0)
                newList.push(xs[listLength])
                listLength = listLength - 1
	end
        return newList
end

#check if the argument n is prime (is only divisible by 1 and itself). The smallest prime is 2.
def is_prime(n)
        if(n<2)
                return false
	end
        for i in 2..n-1
                if(n%i==0)
                        return false
		end
	end
	return true
end

=begin
return a list of all values that show up in xs at least once.
The answer must not include any duplicates, and must report the 
occurring values in the same order as their first occurrence.
Think of this as returning a copy of the list with all duplicates removed. 
=end
def nub(xs)
        if(xs.length<=1)
                return xs
	end
        newList = []
        for x in xs
                if !newList.include? x 
                        newList.push(x)
		end
	end
	return newList
end

def zipwith(f, xs, ys)
        newList = []
        if(xs.length <= ys.length)
                for x in 0..xs.length-1
			newList.push(f.call(xs[x], ys[x]))
		end
        else   
                for x in 0..ys.length-1
                        newList.push(f.call(xs[x],ys[x]))
		end
	end
        return newList
end

#given a number n, we generate successive integer values in a sequence,
#which must end with a 1. The rules for successive values are: 
def collatz(n)
        newList = [n]
        while n != 1
                if n % 2 == 0
                        n = n / 2
                else
                        n = n * 3 + 1
		end
                newList.push(n)
	end
        return newList
end

#REPORT CLASS ###############
class Report
	def initialize(mean, median, mode)
		@mean = mean
		@median = median
		@mode = mode
	end
#GETTERS AND SETTERS
#MEAN
	def mean=(mean)
		@mean = mean
	end

	def mean
		@mean
	end

#MEDIAN
	def median=(median)
		@median = median
	end

	def median
		@median
	end
#MODE
	def mode=(mode)
		@mode = mode
	end

	def mode
		@mode
	end

#TO STRING METHOD
	def str
		return "(#{@mean}, #{@median}, #{@mode})"
	end
end
###########################


=begin
Given the name of a text file that contains one or more lines, 
each with a single integer on that line,
calculate these three properties and return them as a Report object.
=end
def file_report(filename)
        newList = []
        intList = []
	f = File.open(filename, "r")
		f.each_line do |line|
		newList.push(Integer(line))
	end
        newList = newList.sort
	
	mean = mean(newList)
	median = median(newList)
	mode = mode(newList)
	Report.new(mean, median, mode)
end
 
def median(xs)
        if xs.length <=1
                return xs
	end
	length = xs.length
        mid = xs.length/2
        if xs.length % 2 == 0
                retVal = ((xs[mid-1].to_f+xs[mid].to_f)/2).to_f
                if retVal % 1 == 0
                        return retVal.to_f
                else
                        return retVal.to_f
		end
	end
        return xs[mid].to_f
end
 
def mean(xs)
        avg = 0
        for x in 0..xs.length-1
                avg = avg + xs[x].to_f
	end
        return (avg/xs.length).to_f
end

def mode(xs)
        modeList = []
        count = 0
        holder = xs[0]-1
        maxCount = 0
        for x in 0..xs.length-1
                if xs[x] == holder
                        if maxCount == 0
                                modeList = []
                                maxCount = 1
			end
                        count = count + 1
                        if count == maxCount or maxCount==0
                                if !modeList.include? xs[x]
                                        modeList.push(xs[x])
				end
			end
                        if count > maxCount
                                maxCount = maxCount + 1
                                modeList = []
                                modeList.push(xs[x])
			end
                elsif maxCount == 0
                        modeList.push(xs[x])
                        holder = xs[x]
                else
                        holder = xs[x]
                        count = 0
		end
	end
        return modeList
end


# Given a 9x9 2d list, check if it represents a valid, solved sudoku. 
def check_sudoku(grid)
        return (check_rows(grid) and check_cols(grid) and check_squares(grid))
end
 
def check_cols(grid)
        newGrid = []
        check = 9
        colCount = -1
        cleanList = []
        for z in 0...9
                for p in 0...9
                        cleanList.push(grid[p][z])
                        if cleanList.length % 9 == 0
                                newSet = cleanList.uniq
                                cleanList = []
                                if newSet.length != 9
                                        return false
				end
			end
		end
	end
        return true
end
 
def check_rows(grid)
        for x in grid
                if x.length != 9
                        return false
		end
                newSet = x.uniq
                if newSet.length != 9
                        return false
		end
	end
        return true
end
 
def check_squares(grid)
        list1 = []
        list2 = []
        list3 = []
 
        cleanList = []
        for z in 0...9
                for p in 0...9
                        cleanList.push(grid[p][z])
		end
	end
        for n in 0...81
                if n % 9 == 0 or  n%9 ==1  or n%9 ==2
                        list1.push(cleanList[n])
                elsif n%9 ==3 or n%9==4 or n%9 ==5
                        list2.push(cleanList[n])
                else
                        list3.push(cleanList[n])
		end
                if n== 26 or n == 53 or n ==80
                        set1 = list1.uniq
                        set2 = list2.uniq
                        set3 = list3.uniq
                        setLength = set1.length + set2.length + set3.length
                        if setLength != 27
                                return false
			end
                        list1 = []
                        list2 = []
                        list3 = []
		end
	end
        return true
end

