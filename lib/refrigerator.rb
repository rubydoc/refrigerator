# 우리나라 아이스크림 공장은 여러가지 종류의 아이스크림을 생산하고 있다. 그런데 공장에서 생산된 아이스크림의 
# 형태를 그대로 보존하기 위해서는 일정한 온도를 유지해 주어야만 한다. 

# 아이스크림은 종류에 따라 유지해야할 온도의 최소값과 최대값이 정해져 있다. 즉 , 
# A 라는 아이스크림의 유지 온도가 -20 oc ~ -12 oc라면, 냉장고의 온도가 -20 oc에서 -12 oc 사이일 때만 
# 아이스크림은 형태가 변형되지 않고 보관될 수 있다.

# 냉장고의 온도는 고정된 값을 정할 수 있으며 하나의 냉장고에는 여러 종류의 아이스크림이 들어 갈 수 있다.

# 이 아이스크림 공장에서 생산되는 여러 종류의 아이스크림을 모두 보관 할 수 있도록 하는 최소한의 냉장고 수를 구하라.

# 예를들어 유지온도가 각각 
# -20 oc~ -15 oc, 
# -14 oc~ -5 oc , 
# -18 oc~ -13 oc, 
# -5 oc~ -3 oc
# 인 네 개의 아이스크림이 있다고 하면 , -15 oc도 맞추어 놓은 냉장고에 첫 번째와 세 번째 아이스크림을 넣고, 
# -5 oc로 맞추어 놓은 냉장고에 두 번째와 네 번째 아이스크림을 넣으면 두 대의 냉장고로 모든 아이스크림을 보관할 수 있다. 
# 물론 첫 번째 냉장고는 -15 oc대신 -16 oc혹은 -18 oc로 맞추어도 상관없다.

class Refrigerator
	attr_accessor :icecreams, :containable, :refrigerators_count

	def self.find_refs_count *arr
		ref = new(*arr)
		ref.remove_max_overlap
	end

	def initialize *arr
		@refrigerators_count = 0;
		@icecreams = arr.inject([]) { |sum,r| r.sort!; sum << (r[0]..r[1]).to_a }.sort {|arr1,arr2| arr1[0] <=> arr2[0] }		
	end


	def get_containable 
		min = @icecreams.flatten.min
		max = @icecreams.flatten.max
		
		@containable = {}
		(min..max).each do |i|
			@icecreams.each_with_index do |arr, index|
				@containable[i] ?  @containable[i] << index : @containable[i] = [ index ] if arr.include?(i)
			end
		end
		@containable
	end

	def remove_max_overlap
		if icecreams.length > 0
			@refrigerators_count += 1

			get_containable
			overlaps = {}
			@containable.each do |k, v|
				overlaps[v.count] = k 
			end

			max_conatined_arr = overlaps[overlaps.keys.max]
			
			remove_icecreams max_conatined_arr
			remove_max_overlap
		else
			@refrigerators_count
		end
	end

	def remove_icecreams max_conatined_arr
		@containable[max_conatined_arr].sort.reverse.each do |i|
			@icecreams.delete_at i
		end
	end

end	