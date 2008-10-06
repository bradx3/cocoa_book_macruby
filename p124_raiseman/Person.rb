#
#  Person.rb
#  p124_raiseman
#
#  Created by Brad Wilson on 26/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

class Person
	attr_accessor :personName
	attr_accessor :expectedRaise
	
	def initialize
		@expectedRaise = 5.0
		@personName = "New Person"
	end
end
