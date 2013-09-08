require File.expand_path(File.dirname(__FILE__) + '/../lib/refrigerator.rb')

describe Refrigerator do
	describe "#init" do
		it "should have iececreams 2-step array" do 
			ref = Refrigerator.new([-2,-3], [-3,-1], [-4, -3]) 
			ref.icecreams.should == [ [-4, -3], [-3, -2, -1], [-3, -2] ]
		end
	end  
	
	describe "#get_containable" do
		it "should return {-4: 1, -3: 3, -2: 2, -1:, 1}" do 
			ref = Refrigerator.new([-2,-3], [-3,-1], [-4, -3]) 
			ref.get_containable.should == {-4=>[0], -3=>[0, 1, 2], -2=>[1, 2], -1=>[1]}
		end
	end 

	describe "#remove_max_overlap" do 
		it "should return 1" do
			ref = Refrigerator.new([-2,-3], [-3,-1], [-4, -3]) 
			ref.remove_max_overlap.should == 1
		end
	end

	describe ".find_refs_count" do 
		it "should return 1" do
			Refrigerator.find_refs_count([-2,-3], [-3,-1], [-4, -3]).should == 1
		end
		it "should return 2" do
			Refrigerator.find_refs_count([-20,-15], [-14,-5], [-18, -13], [-5,-3]).should == 2
		end
	end

end

